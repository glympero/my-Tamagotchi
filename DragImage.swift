//
//  DragImage.swift
//  my-Tamagotchi
//
//  Created by Lympe on 07/12/15.
//  Copyright © 2015 Lympe. All rights reserved.
//

import Foundation
import UIKit

class DragImage: UIImageView {
    
    //Variable which holds the beginning point
    var originalPosition: CGPoint!
    //Using UIView instead of UIIMage(Even though we know it targets an image) in order to be able to reuse class, with for example a button
    var dropTarget: UIView?
    
    
    //Override some initialisers in order to make it work
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    //Now can implement
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Set our starting position at center
        originalPosition = self.center
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Grab the first object from touches and because it's an optional use if let suntax to check if it exists
        if let touch = touches.first{
            //Superview is the view which we see (i.e. iphone screen with heart-skulls etc)
            let position = touch.locationInView(self.superview)
            //Make our center the starting point which we grab from the position above
            self.center = CGPointMake(position.x, position.y)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        //Return dragged item to the original position
        self.center = originalPosition
        
        if let touch = touches.first, let  target = dropTarget{
            let position = touch.locationInView(self.superview)
            
            //Function which checks if the frame of the target contains a point from position (the current center of our touch)
            if CGRectContainsPoint(target.frame, position){
                //Creating and posting a new notification
                NSNotificationCenter.defaultCenter().postNotificationName("onTargetDropped", object: nil)
            }
        }
    }
}
