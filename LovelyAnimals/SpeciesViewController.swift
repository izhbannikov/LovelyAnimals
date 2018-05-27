//
//  SpeciesViewController.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/24/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

protocol AddScreenViewControllerDelegate
{
    func onAddSpecies(type: String)
}

class SpeciesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddScreenViewControllerDelegate {
    var animals: String!
    @IBOutlet var tableView: UITableView!
    
    var species: [String] {
        return DataManager.sharedInstance.animals[animals]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = animals
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return species.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel!.text = species[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "fromEventTableToAddEvent" {
        let nav = segue.destinationViewController as! UINavigationController
        let vc = nav.topViewController as! AddScreenViewController
        vc.delegate = self
        //}
    }
    
    func onAddSpecies(data: String)
    {
        DataManager.sharedInstance.addSpecies(species: self.animals, newSpecies: data)
        
        // create the index path for the last cell
        let newIndexPath = NSIndexPath(forRow: self.species.count - 1, inSection: 0)
        
        // insert the new cell in the table view and show an animation
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let speciesToRemove = species[indexPath.row]
        
        DataManager.sharedInstance.removeSpecies(species: animals, race: speciesToRemove)
        
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailsViewController = storyboard?.instantiateViewControllerWithIdentifier("SpeciesDetailsViewController") as!SpeciesDetailsViewController
       
        let race = species[indexPath.row]
        let url = DataManager.urlForRace(race)
        
        detailsViewController.race = race
        detailsViewController.url = url
        
        navigationController?.pushViewController(detailsViewController, animated: true)

        
    }

}
