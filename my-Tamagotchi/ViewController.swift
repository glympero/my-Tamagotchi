//
//  ViewController.swift
//  my-Tamagotchi
//
//  Created by Lympe on 06/12/15.
//  Copyright © 2015 Lympe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var imageArray = [UIImage]()
        for var x = 1; x<5; x++ {
            
            imageArray.append(UIImage(named: "idle\(x).png")!)
        }
        monsterImg.animationImages = imageArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating() 
    }


}

