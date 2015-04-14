//
//  ViewController.swift
//  TimelineTest
//
//  Created by Connor Bain on 4/9/15.
//  Copyright (c) 2015 Connor Bain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonScroll: UIScrollView!
    
    // View controller for the popups.
    var popViewController: PopUpViewController!

    func timelineButtonPressed(sender:UIButton){
        
        // Launch a pop up
        // Could easily use the sender.tag to specify specific content.
        self.popViewController = PopUpViewController(nibName: "PopUpViewController", bundle: nil)
        self.popViewController.title = "This is a popup view for button \(sender.tag)"
        self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a popup window for \(sender.tag)", animated: true)
    }
    
    func timelineButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
       
        // Creates a view for the buttons
        let buttonView = UIView()
        buttonView.backgroundColor = UIColor.blackColor()
        buttonView.frame.origin = CGPointMake(0,0)
        let padding = CGSizeMake(20, 10)
        buttonView.frame.size.width = (buttonSize.width + padding.width) * CGFloat(buttonCount)
        buttonView.frame.size.height = (buttonSize.height +  2.0 * padding.height)
       
        // Defines some variables to have buttons at standard distances; Could easily be extended to create an actual timeline (i.e. distance between buttons can be different)
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
        let buttonIncrement = buttonSize.width + padding.width
        let hueIncrement = 1.0 / CGFloat(buttonCount)
        var newHue = hueIncrement
        
        // Begin Button adding code
        // Add Buttons to View - this just procedurally creates buttonCount many buttons with different colors
        for i in 0...(buttonCount - 1)  {
            var button = UIButton.buttonWithType(.Custom) as! UIButton
            button.tag = i
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor(hue: newHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            newHue = newHue + hueIncrement
            button.addTarget(self, action: "timelineButtonPressed:", forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }
        // End button adding code
        
        // Begin Line Code
        // Draw Timeline Line
        let line = UIView()
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.backgroundColor = UIColor.lightGrayColor()
        line.frame = CGRect(origin: CGPoint(x: 0, y: 32.5), size: CGSize(width: buttonView.frame.width, height: 5))

        buttonView.addSubview(line) // Add the line to the screen
        buttonView.sendSubviewToBack(line) // Send it to the back
        // End Line Code
        
        return buttonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the scrolling pageview
        let scrollingView = timelineButtonsView(CGSizeMake(50.0,50.0), buttonCount: 10) // This generates the buttons
        buttonScroll.contentSize = scrollingView.frame.size // Makes sure we actually scroll
        buttonScroll.addSubview(scrollingView) //Adds our stuff to the View
        buttonScroll.showsHorizontalScrollIndicator = true
        buttonScroll.indicatorStyle = .Default
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}