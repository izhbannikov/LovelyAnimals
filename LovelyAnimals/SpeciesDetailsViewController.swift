//
//  SpeciesDetailsViewController.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit
import Foundation

class SpeciesDetailsViewController: UIViewController {
    var race: String?
    var imageFileName : String?
    var url: NSURL?
    //var webViewController: WebViewController?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        /*let image = loadImage(imageFileName)
        if(image != nil) {
            self.imageView.image = image//UIImage(data: self.imageFileName)
        }*/
        //self.imageView.image = UIImage(data: self.imageFileName)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let nav = segue.destinationViewController as! UINavigationController
        let vc = segue.destinationViewController as! WebViewController
        vc.url = self.url
    }

    
    private func loadImage(fileName: String?) -> UIImage? {
        if(fileName == nil) {
            return(nil)
        }
        
        
        if NSFileManager.defaultManager().fileExistsAtPath(fileName!) {
            //let url = NSURL(string: fileName!)
            let url: NSURL = NSURL(fileURLWithPath: fileName!)
            let data = NSData(contentsOfURL: url)
            return(UIImage(data: data!))
        } else {
            return(nil)
        }
    }
    
    
}
