//
//  ViewController.swift
//  LovelyAnimals
//
//  Created by user on 5/24/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

protocol AddEditAnimalDelegate
{
    func onAddAnimal(name: String)
}

class AnimalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddEditAnimalDelegate {

    var animals: [String] = DataManager.sharedInstance.animalsList
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Lovely animals"
        
        
        // tapRecognizer, placed in viewDidLoad
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(SpeciesViewController.longPress(_:)))
        longPressRecognizer
        self.tableView.addGestureRecognizer(longPressRecognizer)
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
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
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) ->[UITableViewRowAction]? {
        
        let moreRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "More", handler:{action, indexpath in
            
            self.onEditCall(indexPath.row)
            
        })
        
        moreRowAction.backgroundColor = UIColor(red: 0.298, green: 0.851, blue: 0.3922, alpha: 1.0);
        
        let deleteRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler:{action, indexpath in
            
            let toRemove = self.animals[indexPath.row]
            
            DataManager.sharedInstance.removeAnimal(toRemove)
            self.animals = DataManager.sharedInstance.animalsList
            tableView.beginUpdates()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        })
        
        return [deleteRowAction, moreRowAction]
    }
    
    
    
    func onAddAnimal(name: String)
    {
        DataManager.sharedInstance.addAnimal(name)
        
        if !self.animals.contains(name) {
            self.animals.append(name)
        
            // create the index path for the last cell
            let newIndexPath = NSIndexPath(forRow: self.animals.count-1, inSection: 0)
        
            // insert the new cell in the table view and show an animation
            tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            tableView.endUpdates()
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "fromEventTableToAddEvent" {
        let nav = segue.destinationViewController as! UINavigationController
        let vc = nav.topViewController as! AddEditAnimal
        vc.delegate = self
        //}
    }

    func onEditCall(row: Int) {
        let editScreenViewController = storyboard?.instantiateViewControllerWithIdentifier("AddEditAnimal") as!AddEditAnimal
        let race = self.animals[row]
        
        editScreenViewController.animalName = race
        editScreenViewController.delegate = self
        let navController = UINavigationController(rootViewController: editScreenViewController) // Creating a navigation controller with editScreenViewController at the root of the navigation stack.
        self.presentViewController(navController, animated:true, completion: nil)
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


}

