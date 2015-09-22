//
//  ViewController.swift
//  MOHUDDemo
//
//  Created by Moath_Othman on 9/21/15.
//  Copyright © 2015 Moba. All rights reserved.
//

import UIKit

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
        MOHUD.show(periodOfTime:2)

    }

    @IBAction func showWithStatus(sender: AnyObject) {
        MOHUD.show("Processing", period: 2)
    }

    @IBAction func showSuccess(sender: AnyObject) {
        MOHUD.showSuccess("You Made it")
    }

    @IBAction func showFailure(sender: AnyObject) {
        MOHUD.showWithError("Failed :X")
    }
    @IBOutlet weak var showFailure: UIButton!
}

