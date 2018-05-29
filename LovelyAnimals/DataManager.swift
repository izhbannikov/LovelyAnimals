//
//  DataManager.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/24/18.
//  Copyright © 2018 Home. All rights reserved.
//

import Foundation

class DataManager {
    var animals: [String:[String: [String]]]
    
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
        if let animalsInfo = userDefaults.valueForKey("animals") as? [String:[String: [String]]] {
            animals = animalsInfo
        } else {
            // add default data
            animals = [
                "Foxes": ["Red fox" : [], "Grey fox": [], "Fennec fox":[], "Bat-eared fox":[], "Arctic fox": []],
                "Wolfes" : ["Grey wolf": []],
                "Dogs" : ["Spaniel": []]
            ]
        }
    }
    
    var animalsList: [String] {
        var list: [String] = []
        for name in animals.keys {
            list.append(name)
        }
        
        //list.sortInPlace(<)
        
        return list
    }
    
    func saveData() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(animals, forKey: "animals")
    }
    
    func addSpecies(species inSpecies: String, newSpecies: [String: [String]]) {
        if var species = animals[inSpecies] {
            if(newSpecies[newSpecies.keys.first!] != nil) {
                species[newSpecies.keys.first!] = newSpecies[newSpecies.keys.first!]
            } else {
                species[newSpecies.keys.first!] = []
            }
            
            //species.append(newSpecies)
            animals[inSpecies] = species
        }
        
        saveData()
    }
    
    func removeSpecies(species inSpecies: String, race inRace: String) {
        if var species = animals[inSpecies] {
            if species[inRace] != nil {
                species.removeValueForKey(inRace)
                animals[inSpecies] = species
                saveData()
            }
            
        }
    }
    
    class func urlForRace(race: String) -> NSURL {
        // replace spaces with _
        let safeString = race.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        return NSURL(string: "http://en.wikipedia.org/wiki/" + safeString)!
    }
    
    // Methods for saving images
    
    
}