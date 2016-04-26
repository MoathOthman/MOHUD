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
        MOHUD.show(periodOfTime: 2)
        MOHUD.setBlurStyle(.Light)
        MOHUD.onCancel = {
            debugPrint("User Canceled")
        }
        MOHUD.onContinoue = {
            debugPrint("User want to contniue without the progress indicator ")
        }
    }
    @IBAction func showWithCancelAndContinue(sender: AnyObject) {
        MOHUD.show(periodOfTime: 10, withCancelAndContinue: true)
        MOHUD.setBlurStyle(.Dark)
        MOHUD.onCancel = {
            debugPrint("User Canceled")
        }
        MOHUD.onContinoue = {
            debugPrint("User want to contniue without the progress indicator ")
        }
    }
    @IBAction func showWithStatus(sender: AnyObject) {
        MOHUD.showWithStatus("Processing", period: 2)
        
    }

    @IBAction func showSuccess(sender: AnyObject) {
        MOHUD.showSuccess("You Made it")
    }

    @IBAction func showSubtitle(sender: AnyObject) {
        MOHUD.showSubtitle(title: "Connection", subtitle: "Please Wait", period: 3)
    }
    @IBAction func showFailure(sender: AnyObject) {
        MOHUD.showWithError("Failed :(")
    }
    @IBOutlet weak var showFailure: UIButton!
}

