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

    var students: [String] = []
    var lastStudent: Int = 0
    
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
        let millis = Date().millisecondsSince1970
    
        // TODO: Call service for list
        students.shuffle()
        lastStudent = 0
    }
    
    @IBAction func nextPushed() {
        if (students.count>0)
        {
            if (lastStudent == students.count)
            {
                // shuffle again
                students.shuffle()
                lastStudent = -1
            }
            lastStudent = lastStudent + 1
            studentLabel.setText(students[lastStudent])
        }
        else {
            studentLabel.setText("No Students Available")
        }
    }
    
}

// I love this extension shiate

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

extension Array {
    
    // Non-mutating shuffle
    var shuffled : Array {
        let totalCount : Int = self.count
        var shuffledArray : Array = []
        var count : Int = totalCount
        var tempArray : Array = self
        for _ in 0..<totalCount {
            let randomIndex : Int = Int(arc4random_uniform(UInt32(count)))
            let randomElement : Element = tempArray.remove(at: randomIndex)
            shuffledArray.append(randomElement)
            count -= 1
        }
        return shuffledArray
    }
    
    // Mutating shuffle
    mutating func shuffle() {
        let totalCount : Int = self.count
        var shuffledArray : Array = []
        var count : Int = totalCount
        var tempArray : Array = self
        for _ in 0..<totalCount {
            let randomIndex : Int = Int(arc4random_uniform(UInt32(count)))
            let randomElement : Element = tempArray.remove(at: randomIndex)
            shuffledArray.append(randomElement)
            count -= 1
        }
        self = shuffledArray
    }
}

