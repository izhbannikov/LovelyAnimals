//
//  ViewController.swift
//  LovelyAnimals
//
//  Created by user on 5/24/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class AnimalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var animals: [String] = DataManager.sharedInstance.animalsList
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Lovely animals"
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel!.text = animals[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let speciesViewController = storyboard?.instantiateViewControllerWithIdentifier("SpeciesViewController") as! SpeciesViewController
        
        speciesViewController.animals = animals[indexPath.row]
        
        navigationController?.pushViewController(speciesViewController, animated: true)
    }

}

