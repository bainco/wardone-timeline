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
    
    var popViewController : PopUpViewControllerSwift!

    func colorButtonPressed(sender:UIButton){
        
        self.popViewController = PopUpViewControllerSwift(nibName: "PopUpViewController", bundle: nil)
        self.popViewController.title = "This is a popup view for button \(sender.tag)"
        self.popViewController.showInView(self.view, withImage: UIImage(named: "typpzDemo"), withMessage: "You just triggered a popup window for \(sender.tag)", animated: true)
    }
    
    func colorButtonsView(buttonSize:CGSize, buttonCount:Int) -> UIView {
        //creates color buttons in a UIView
        let buttonView = UIView()
        
        buttonView.backgroundColor = UIColor.blackColor()
        buttonView.frame.origin = CGPointMake(0,0)
        
        let padding = CGSizeMake(20, 10)
        buttonView.frame.size.width = (buttonSize.width + padding.width) * CGFloat(buttonCount)
        buttonView.frame.size.height = (buttonSize.height +  2.0 * padding.height)
       
        //add buttons to the view
        var buttonPosition = CGPointMake(padding.width * 0.5, padding.height)
        let buttonIncrement = buttonSize.width + padding.width
        let hueIncrement = 1.0 / CGFloat(buttonCount)
        var newHue = hueIncrement
        
        for i in 0...(buttonCount - 1)  {
            var button = UIButton.buttonWithType(.Custom) as! UIButton
            button.tag = i
            button.frame.size = buttonSize
            button.frame.origin = buttonPosition
            buttonPosition.x = buttonPosition.x + buttonIncrement
            button.backgroundColor = UIColor(hue: newHue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
            newHue = newHue + hueIncrement
            button.addTarget(self, action: "colorButtonPressed:", forControlEvents: .TouchUpInside)
            buttonView.addSubview(button)
        }

        let line = UIView()
        line.setTranslatesAutoresizingMaskIntoConstraints(false)
        line.backgroundColor = UIColor.lightGrayColor()
        line.frame = CGRect(origin: CGPoint(x: 0, y: 32.5), size: CGSize(width: buttonView.frame.width, height: 5))

        buttonView.addSubview(line)
        buttonView.sendSubviewToBack(line)
        return buttonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrolling pageview
        let scrollingView = colorButtonsView(CGSizeMake(50.0,50.0), buttonCount: 10)
        buttonScroll.contentSize = scrollingView.frame.size
        buttonScroll.addSubview(scrollingView)
        buttonScroll.showsHorizontalScrollIndicator = true
        buttonScroll.indicatorStyle = .Default
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}