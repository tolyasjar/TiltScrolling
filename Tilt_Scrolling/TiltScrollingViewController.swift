//
//  TiltScrollingViewController.swift
//  Tilt_Scrolling
//
//  Created by Toleen Jaradat on 7/14/16.
//  Copyright © 2016 Toleen Jaradat. All rights reserved.
//

import UIKit
import CoreMotion

class TiltScrollingViewController: UIViewController {
    
    @IBOutlet weak var scrollTextView: UITextView!
    var motionManager: CMMotionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() { //To show the text from the beginning in the text view
        super.viewDidLayoutSubviews()
        
        scrollTextView.setContentOffset(CGPointZero, animated: false)
    }

 
    
    @IBAction func tiltScrollingButtonPressed(sender: AnyObject) {
        
        motionManager = CMMotionManager()
        
        if self.motionManager.deviceMotionAvailable {
            
            self.motionManager.deviceMotionUpdateInterval = 0.1
            
            self.motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data :CMDeviceMotion?, error :NSError?) in
                
                if let data = data {
                    
                    let accelerationY = -1 * (data.gravity.y)
                    print(accelerationY)
                    
                    if (0.65 < accelerationY  && accelerationY < 0.80 ) {
                        print ("tilt backwords")
                        self.scrollUp()
                        
                        
                        
                    } else if (0.80 < accelerationY && accelerationY < 0.95) {
                        print ("tilt forword")
                        self.scrollDown()
                    }
                }
            })
            
        }
    
    }
    
    func scrollDown() {
        
        var positionY = self.scrollTextView.contentOffset.y
        positionY += 50
        if(positionY < (self.scrollTextView.contentSize.height - self.scrollTextView.contentOffset.y) * 1.25)
        
        {
            let point = CGPointMake(self.scrollTextView.frame.origin.x,  positionY)
            self.scrollTextView.setContentOffset( point, animated: true)
        }
        
    }
    
    func scrollUp() {
        
        var positionY = self.scrollTextView.contentOffset.y
        positionY -= 50
        
        if(positionY > 0)
        {
            let point = CGPointMake(self.scrollTextView.frame.origin.x , positionY)
            self.scrollTextView.setContentOffset( point, animated: true)
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
}
