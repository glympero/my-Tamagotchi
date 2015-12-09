//
//  MonsterImage.swift
//  my-Tamagotchi
//
//  Created by Lympe on 07/12/15.
//  Copyright © 2015 Lympe. All rights reserved.
//

import Foundation
import UIKit

class MonsterImage: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //When app loads, play the idle animation
        //playIdleAnimation()
    }
    
    func playIdleAnimation(){
        self.image = UIImage(named: "idle1")
        self.animationImages = nil
        
        var imageArray = [UIImage]()
        for var x = 1; x<5; x++ {
            
            imageArray.append(UIImage(named: "idle\(x).png")!)
        }
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 0
        self.startAnimating()

    }
    
    func playDeathAnimation(){
        //The default image (we want to look dead and not standing)
        self.image = UIImage(named: "dead5")
        
        //Set animationImages to nil (for example when games restarts dont want the dead images along with the idle images
        self.animationImages = nil
        var imageArray = [UIImage]()
        for var x = 1; x<6; x++ {
            imageArray.append(UIImage(named: "dead\(x).png")!)
        }
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()

    }
    
    func playResurrectAnimation(){
        //The default image (we want to look dead and not standing)
        self.image = UIImage(named: "dead1")
        
        //Set animationImages to nil (for example when games restarts dont want the dead images along with the idle images
        self.animationImages = nil
        var imageArray = [UIImage]()
        for var x = 5; x > 0; x-- {
            imageArray.append(UIImage(named: "dead\(x).png")!)
        }
        self.animationImages = imageArray
        self.animationDuration = 0.8
        self.animationRepeatCount = 1
        self.startAnimating()
    }
    
}
