//
//  ViewController.swift
//  my-Tamagotchi
//
//  Created by Lympe on 06/12/15.
//  Copyright © 2015 Lympe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var monsterImg: WorkerImage!
    @IBOutlet weak var heartImg: DragImage!
    @IBOutlet weak var workerImg: WorkerImage!
    @IBOutlet weak var foodImg: DragImage!
    
    @IBOutlet weak var skull1Img: UIImageView!
    
    @IBOutlet weak var skull2Img: UIImageView!
    
    @IBOutlet weak var skull3Img: UIImageView!
    @IBOutlet weak var restartBtn: UIButton!
    
    @IBOutlet weak var heart_food: DragImage!
    
    @IBOutlet weak var restartLbl: UILabel!
    //Music Players
    var musicPlayer : AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxFood: AVAudioPlayer!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    var penalties = 0
    var timer: NSTimer!
    var currentItem:UInt32 = 0
    
    var monsterHappy = false
    
    var chooseChar: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //monsterImg.playIdleAnimation()
       // monsterImg.playDeathAnimation()
        if chooseChar == "monster"{
            foodImg.dropTarget = monsterImg
            heartImg.dropTarget = monsterImg
            heart_food.dropTarget = monsterImg
            workerImg.hidden = true
            monsterImg.hidden = false
        }else if chooseChar == "human" {
            foodImg.dropTarget = workerImg
            heartImg.dropTarget = workerImg
            heart_food.dropTarget = workerImg
            workerImg.hidden = false
            monsterImg.hidden = true
        }
        
        
        do{
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("bite", ofType: "wav")!))
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("death", ofType: "wav")!))
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heart", ofType: "wav")!))
            try sfxFood = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skull", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            sfxBite.prepareToPlay()
            sfxHeart.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxFood.prepareToPlay()
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
        
        
        startGame()
        
    }

    func itemDroppedOnChar (notif: AnyObject){
        monsterHappy = true
        startTimer()
        disableItems()
        if currentItem == 0{
            sfxHeart.play()
        }else if currentItem == 1{
            sfxFood.play()
        }else if currentItem == 2 {
            sfxHeart.play()
            sfxFood.play()
        }
        
    }
    
    func disableItems(){
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        heart_food.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false

    }
    
    func changeGameState(){
        
        if !monsterHappy{
            
            penalties++
            sfxBite.play()
            if penalties == 1 {
                skull1Img.alpha = OPAQUE
            }else if penalties == 2 {
                skull2Img.alpha = OPAQUE
            }else if penalties >= MAX_PENALTIES {
                skull3Img.alpha = OPAQUE
                gameOver()
            }else{
                dimAllSkulls()
            }
        }
        
        randomItem()
        monsterHappy = false
        
        
    }
    
    @IBAction func restartGame(sender: AnyObject) {
        monsterImg.playResurrectAnimation()
        penalties = 0
        foodImg.hidden = false
        heartImg.hidden = false
        heart_food.hidden = false
        disableItems()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "startGame", userInfo: nil, repeats: false)
        sfxHeart.play()
        //startGame()
        
    }
    
    func startGame(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "itemDroppedOnChar:", name: "onTargetDropped", object: nil)
        restartBtn.hidden = true
        restartLbl.hidden = true
        dimAllSkulls()
        startTimer()
        randomItem()
        monsterImg.playIdleAnimation()
        
    }
    
    func randomItem(){
        let rand = arc4random_uniform(3)
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
            heart_food.alpha = DIM_ALPHA
            heart_food.userInteractionEnabled = false
            //sfxHeart.play()
            
        }else if rand == 1 {
            foodImg.alpha = OPAQUE
            heartImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = true
            heartImg.userInteractionEnabled = false
            heart_food.alpha = DIM_ALPHA
            heart_food.userInteractionEnabled = false
            //sfxFood.play()
        }else if rand == 2{
            foodImg.alpha = DIM_ALPHA
            heartImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = true
            heartImg.userInteractionEnabled = false
            heart_food.alpha = OPAQUE
            heart_food.userInteractionEnabled = true
            
        }
        
        currentItem = rand
        
    }
    
    func startTimer(){
        //if timer is counting, stop it
        if timer != nil{
            timer.invalidate()
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func gameOver(){
        timer.invalidate()
        
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        
        restartLbl.hidden = false
        restartBtn.hidden = false
        foodImg.hidden = true
        heartImg.hidden = true
        heart_food.hidden = true
        disableItems()
    }
    
    func dimAllSkulls(){
        skull1Img.alpha = DIM_ALPHA
        skull2Img.alpha = DIM_ALPHA
        skull3Img.alpha = DIM_ALPHA
    }
    
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        print("I just Touched the screen")
//    }
}

