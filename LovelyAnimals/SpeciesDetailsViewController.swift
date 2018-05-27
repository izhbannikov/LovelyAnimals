//
//  SpeciesDetailsViewController.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class SpeciesDetailsViewController: UIViewController {
    var race: String?
    var url: NSURL?
    //var webViewController: WebViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let nav = segue.destinationViewController as! UINavigationController
        let vc = segue.destinationViewController as! WebViewController
        vc.url = self.url
    }


}
