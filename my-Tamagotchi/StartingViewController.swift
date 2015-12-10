//
//  StartingViewController.swift
//  my-Tamagotchi
//
//  Created by Lympe on 10/12/15.
//  Copyright © 2015 Lympe. All rights reserved.
//

import UIKit

class StartingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "monsterSegue" {
            let viewController = segue.destinationViewController as! ViewController
            viewController.chooseChar = "monster"
        }else if segue.identifier == "humanSegue" {
            let viewController = segue.destinationViewController as! ViewController
            viewController.chooseChar = "human"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
