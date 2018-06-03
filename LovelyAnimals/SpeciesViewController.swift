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
    func onAddSpecies(type: Species)
}

class SpeciesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddScreenViewControllerDelegate {
    var animals: String!
    @IBOutlet var tableView: UITableView!
    
    var species: [String] {
        var list: [String] = []
        
        for i in 0 ..< DataManager.sharedInstance.animals[animals]!.count {
        //for i in DataManager.sharedInstance.animals[animals].name {
            list.append(DataManager.sharedInstance.animals[animals]![i].name)
        }
        return(list)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = animals
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // tapRecognizer, placed in viewDidLoad
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(SpeciesViewController.longPress(_:)))
        longPressRecognizer
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        
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
    
    func onAddSpecies(data: Species)
    {
        
        DataManager.sharedInstance.addSpecies(species: self.animals, newSpecies: data)
        
        // create the index path for the last cell
        let newIndexPath = NSIndexPath(forRow: self.species.count - 1, inSection: 0)
        
        // insert the new cell in the table view and show an animation
        self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        //self.species.append(data.keys.first)
        //self.species.append("aaa")
    }
    /*
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if(editingStyle == .Delete) {
            let speciesToRemove = species[indexPath.row]
        
            DataManager.sharedInstance.removeSpecies(species: animals, race: speciesToRemove)
        
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
     
    }
    */
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) ->[UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "More", handler:{action, indexpath in
            
            self.onEditCall(indexPath.row)
            
        })
        
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            
            let speciesToRemove = self.species[indexPath.row]
                
            DataManager.sharedInstance.removeSpecies(species: self.animals, race: speciesToRemove)
                
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        })
        
        return [deleteRowAction, moreRowAction]
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detailsViewController = storyboard?.instantiateViewControllerWithIdentifier("SpeciesDetailsViewController") as!SpeciesDetailsViewController
       
        let race = species[indexPath.row]
        let url = DataManager.urlForRace(race)
        
        detailsViewController.race = race
        /*if DataManager.sharedInstance.animals[animals]![race]?.count != 0 {
            detailsViewController.imageFileName = DataManager.sharedInstance.animals[animals]![race]![0]
        }*/
        detailsViewController.url = url
        
        navigationController?.pushViewController(detailsViewController, animated: true)

        
    }
    
    //Called, when long press occurred
    func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        
        if longPressGestureRecognizer.state == UIGestureRecognizerState.Began {
            
            let touchPoint = longPressGestureRecognizer.locationInView(self.tableView)
            if let indexPath = tableView.indexPathForRowAtPoint(touchPoint) {
                self.onEditCall(indexPath.row)
            }
        }
    }
    
    func onEditCall(row: Int) {
        let editScreenViewController = storyboard?.instantiateViewControllerWithIdentifier("AddScreenViewController") as!AddScreenViewController
        let race = self.species[row]
        
        editScreenViewController.animals = animals
        editScreenViewController.speciesName = race
        editScreenViewController.delegate = self
        let navController = UINavigationController(rootViewController: editScreenViewController) // Creating a navigation controller with editScreenViewController at the root of the navigation stack.
        self.presentViewController(navController, animated:true, completion: nil)
    }

}
