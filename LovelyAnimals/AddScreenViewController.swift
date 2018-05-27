//
//  AddScreenViewController.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class AddScreenViewController: UIViewController {
    var animals: String!
    @IBOutlet var tfNewName: UITextField!
    var delegate:AddScreenViewControllerDelegate! = nil
    
    var mainViewController: SpeciesViewController?
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
    
        super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.

    }


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

    @IBAction func cancelButtonTapped(sender_: UIBarButtonItem) {
    
        self.dismissViewControllerAnimated(true, completion: nil)

    }



    @IBAction func saveButtonTapped(sender_: UIBarButtonItem) {
        if (delegate != nil) {
            delegate?.onAddSpecies(tfNewName.text!.capitalizedString)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

