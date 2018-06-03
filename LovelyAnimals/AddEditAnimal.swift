//
//  AddEditAnimal.swift
//  LovelyAnimals
//
//  Created by Ilya on 6/3/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Foundation

class AddEditAnimal: UIViewController {
    var animalName: String?
    var delegate:AddEditAnimalDelegate! = nil
    @IBOutlet var tfAnimalName: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.animalName != nil {
            self.tfAnimalName.text = animalName
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    @IBAction func cancelButtonTapped(sender_: UIBarButtonItem) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBAction func saveButtonTapped(sender_: UIBarButtonItem) {
        if (delegate != nil) {
            delegate?.onAddAnimal(tfAnimalName.text!)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    

}
