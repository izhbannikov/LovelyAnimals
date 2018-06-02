//
//  AddScreenViewController.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Photos

class AddScreenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var animals: String!
    var speciesName: String!
    @IBOutlet var tfNewName: UITextField!
    var delegate:AddScreenViewControllerDelegate! = nil
    let imagePicker = UIImagePickerController()
    @IBOutlet var imageName: UILabel!
    @IBOutlet var imageButton: UIButton!
    var mainViewController: SpeciesViewController?
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
    
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        imagePicker.delegate = self
        if self.speciesName != nil {
            self.tfNewName.text = speciesName
        }
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
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }



    @IBAction func saveButtonTapped(sender_: UIBarButtonItem) {
        if (delegate != nil) {
            var sp = [String: [String]]()
            sp[tfNewName.text!.capitalizedString] = []
            sp[tfNewName.text!.capitalizedString]?.append(imageName.text!)
            delegate?.onAddSpecies(sp)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func loadImageButtonTapped() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil {
            if let imageURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
                self.imageName.text = imageURL.path!
            }        }
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}

