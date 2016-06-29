//
//  ViewController.swift
//  MOHUDDemo
//
//  Created by Moath_Othman on 9/21/15.
//  Copyright © 2015 Moba. All rights reserved.
//

import UIKit
//import MOHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(animated: Bool) {

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showDefault(sender: AnyObject) {
        MOHUD.show()
        MOHUD.setBlurStyle(.Light)
        MOHUD.onCancel = {
            debugPrint("User Canceled")
        }
        MOHUD.onContinoue = {
            debugPrint("User want to contniue without the progress indicator ")
        }
        MOHUD.hideAfter(3)
    }
    @IBAction func showWithCancelAndContinue(sender: AnyObject) {
        MOHUD.show(true)
        MOHUD.setBlurStyle(.Dark)
        MOHUD.onCancel = {
            debugPrint("User Canceled")
        }
        MOHUD.onContinoue = {
            debugPrint("User want to contniue without the progress indicator ")
        }
    }
    @IBAction func showWithStatus(sender: AnyObject) {
        MOHUD.showWithStatus("Processing")
        MOHUD.hideAfter(3)
    }

    @IBAction func showSuccess(sender: AnyObject) {
        MOHUD.showSuccess("You Made it so now you can fly")
    }

    @IBAction func showSubtitle(sender: AnyObject) {
        MOHUD.showSubtitle(title: "Connection", subtitle: "Please Wait")
        MOHUD.hideAfter(3)
    }
    @IBAction func showFailure(sender: AnyObject) {
        MOHUD.showWithError("Failed :(")
    }
    @IBOutlet weak var showFailure: UIButton!
}
@IBDesignable
class GradientView: UIView {
    override func drawRect(rect: CGRect) {
        //2 - get the current context
        let startColor = UIColor ( red: 0.1216, green: 0.1294, blue: 0.1412, alpha: 1.0 )
        let endColor = UIColor ( red: 0.4745, green: 0.7412, blue: 0.8353, alpha: 1.0 )
        let context = UIGraphicsGetCurrentContext()
        let colors = [startColor.CGColor, endColor.CGColor]
        
        //3 - set up the color space
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //4 - set up the color stops
        let colorLocations:[CGFloat] = [0.0, 1.0]
        
        //5 - create the gradient
        let gradient = CGGradientCreateWithColors(colorSpace,
                                                  colors,
                                                  colorLocations)
        
        //6 - draw the gradient
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x:self.bounds.width
            , y:self.bounds.height)
        CGContextDrawLinearGradient(context,
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    CGGradientDrawingOptions(rawValue: 0))
    }
}

