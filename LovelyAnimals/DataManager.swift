//
//  DataManager.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/24/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

protocol Animal {
    var name: String { get set }
    
}

class Species: NSObject, Animal, NSCoding {
    var pictures: [String]
    var name : String
    
    init(name: String, pictures: [String]?) {
        self.name = name
        if pictures != nil {
            self.pictures = pictures!
        } else {
            self.pictures = []
        }
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey("name") as! String
        let pictures = aDecoder.decodeObjectForKey("pictures") as! [String]
        self.init(name: name, pictures: pictures)
    }
    
    func encodeWithCoder(_aCoder: NSCoder) {
        _aCoder.encodeObject(name, forKey: "name")
        _aCoder.encodeObject(pictures, forKey: "pictures")
    }
    
    func addPicture(path: String?) {
        if path != nil {
            self.pictures.append(path!)
        }
    }
}

class DataManager {
    var animals: [String: [Species]]
    let defaultAnimals: [String: [Species]] = [
        "Foxes": [Species(name: "Red fox", pictures: []), Species(name: "Gray fox", pictures: []), Species(name: "Fennec fox", pictures: []), Species(name: "Bat-eared fox", pictures: []), Species(name: "Arctic fox", pictures: [])],
        "Wolves" : [Species(name: "Gray wolf", pictures: [])],
        "Dogs" : [Species(name: "Spaniel", pictures: [])]
    ]

    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : DataManager? = nil
    }
    
    class var sharedInstance : DataManager {
        dispatch_once(&Static.onceToken) {
            Static.instance = DataManager()
        }
        return Static.instance!
    }
    
    
    
    init() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let decoded  = userDefaults.objectForKey("animals") as? NSData
        //let decodedSpecies = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as? [String: Species]
        if decoded != nil {
            if let animalsInfo = NSKeyedUnarchiver.unarchiveObjectWithData(decoded!) as? [String: [Species]] {
                self.animals = animalsInfo
            } else {
                self.animals = defaultAnimals
            }
        } else {
            // add default data
            self.animals = defaultAnimals
        }
    }
    
    var animalsList: [String] {
            var list: [String] = []
            for name in animals.keys {
                list.append(name)
            }
            return list
    
    }

    func saveData() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(self.animals)
        userDefaults.setValue(encodedData, forKey: "animals")
        userDefaults.synchronize()
        
    }
    
    func addAnimal(name: String) {
        self.animals[name] = []
        saveData()
    }
    
    func addSpecies(species inSpecies: String, newSpecies: Species) {
        if var species = animals[inSpecies] {
            species.append(newSpecies)
            animals[inSpecies] = species
        }
        
        saveData()
    }
    
    func removeAnimal(inRace: String) {
        animals.removeValueForKey(inRace)
        saveData()
    }
    
    func removeSpecies(species inSpecies: String, race inRace: String) {
        if var species = animals[inSpecies] {
            var indexToDel : Int = 0
            for i in 0 ..< species.count {
                if species[i].name == inRace {
                    indexToDel = i
                }
            }
            species.removeAtIndex(indexToDel)
            animals[inSpecies] = species
            saveData()
        }
    }
    
    class func urlForRace(race: String) -> NSURL {
        // replace spaces with _
        let safeString = race.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        return NSURL(string: "http://en.wikipedia.org/wiki/" + safeString)!
    }
    
    // Methods for saving images
    
    
}