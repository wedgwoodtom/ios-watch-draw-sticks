//
//  InterfaceController.swift
//  DrawSticks WatchKit Extension
//
//  Created by Tom Patterson on 3/28/18.
//  Copyright © 2018 Tom Patterson. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var drawSticksButton: WKInterfaceButton!
    @IBOutlet var studentLabel: WKInterfaceLabel!
    @IBOutlet var nextButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func drawSticksPushed() {
    }
    
    @IBAction func nextPushed() {
    }
    
}