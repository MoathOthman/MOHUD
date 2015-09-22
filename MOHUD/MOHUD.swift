//
//  MOHUD.swift
//  OnTheMap
//
//  Created by Moath_Othman on 6/27/15.
//  Copyright (c) 2015 Moba. All rights reserved.
//

import UIKit

@objc class MOHUD: UIViewController {
    static var me:MOHUD?
    //MARK: Outlets
    @IBOutlet weak var loaderContainer: UIVisualEffectView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    //MARK: variables
    var statusString: String = ""
    var failureString: String = ""
    var titleString: String = ""

    override func viewWillAppear(animated: Bool) {
        if MOHUD.me != nil {
            self.commonSetup(MOHUD.me!)
        }
    }
    //MARK: Constructor
    class func ME(_me:MOHUD?) -> MOHUD?{
        dismiss() // if any there dismiss it
        me = _me
        if let me = _me {
            //            me.commonSetup(me)
            return me
        }
        return nil
    }//0x7ff102d7e410
    //MARK: Factory
    class func MakeProgressHUD() {
         ME(self.make(.progress) as? MOHUD)
    }
    class func MakeSuccessHUD() {
         ME(self.make(.success) as? MOHUD)
    }
    class func MakeFailureHUD() {
        ME(self.make(.failure) as? MOHUD)
    }
    class func MakeSubtitleHUD() {
        ME(self.make(.subtitle) as? MOHUD)
    }
    //MARK: Subtitle
    class func showSubtitle(title title:String, subtitle:String) {
        MakeSubtitleHUD()
        MOHUD.me?.statusString = subtitle
        MOHUD.me?.titleString = title
        MOHUD.me?.show()
    }
    class func showSubtitle(title title:String, subtitle:String, period: NSTimeInterval) {
        MakeSubtitleHUD()
        MOHUD.me?.statusString = subtitle
        MOHUD.me?.titleString = title
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }
    //MARK: Fail
    class func showWithError(errorString:String) {
        MakeFailureHUD()
        MOHUD.me?.failureString = errorString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: 2)
    }
    class func showWithError(errorString:String, period: NSTimeInterval) {
        MakeFailureHUD()
        MOHUD.me?.failureString = errorString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }
    //MARK: Success
    class func showSuccess(successString: String) {
        MakeSuccessHUD()
        MOHUD.me?.statusString = successString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: 2)
    }
    class func showSuccess(successString: String, period: NSTimeInterval) {
        MakeSuccessHUD()
        MOHUD.me?.statusString = successString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }
    //MARK: Default show
    class func show() {
        MakeProgressHUD()
        MOHUD.me?.show()
    }
    class func show(periodOfTime period: NSTimeInterval) {
        MakeProgressHUD()
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }

    class func show(status: String) {
        MakeProgressHUD()
        MOHUD.me?.statusString = status
        MOHUD.me?.show()
    }
    class func show(status: String, period: NSTimeInterval) {
        MakeProgressHUD()
        MOHUD.me?.statusString = status
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }
    //MARK: Show/hide and timer
    private func show() {
        MOHUD.me?.view.alpha = 0;
        //NOTE: Keywindow should be shown first 
        if let keywindow = UIApplication.sharedApplication().keyWindow {
            keywindow.addSubview(self.view)
            UIView.animateWithDuration(1.55, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                MOHUD.me?.view.alpha = 1;
                }) { (finished) -> Void in

            }
        }
    }

    class func dismiss() {
        if let _me = me {
            UIView.animateWithDuration(0.45, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                _me.view.alpha = 0;
                }) { (finished) -> Void in
                    _me.view.removeFromSuperview()

            }
        }
    }
    private var hideTimer: NSTimer?
    private func hide(afterDelay delay: NSTimeInterval) {
        hideTimer?.invalidate()
        hideTimer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self.classForCoder, selector: Selector("dismiss"), userInfo: nil, repeats: false)
    }

    @IBAction private func hideHud(sender: AnyObject) {
        MOHUD.dismiss()
    }
}


//MARK: Scenses organizing
struct MOStoryBoardID {
    static let progress = "Default"
    static let subtitle = "subtitle"
    static let success = "success"
    static let failure = "failure"
}

enum MOSceneType {
    case progress,success,failure,subtitle
}

extension MOHUD {
    class func make(type : MOSceneType) -> AnyObject {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "MOHUD", bundle: nil)
        switch type {
        case .progress:
            return mainStoryBoard.instantiateViewControllerWithIdentifier(MOStoryBoardID.progress)
        case .success:
            return mainStoryBoard.instantiateViewControllerWithIdentifier(MOStoryBoardID.success)
        case .failure:
            return mainStoryBoard.instantiateViewControllerWithIdentifier(MOStoryBoardID.failure)
        case .subtitle:
            return mainStoryBoard.instantiateViewControllerWithIdentifier(MOStoryBoardID.subtitle)
        }
    }
}

extension MOHUD {
    func commonSetup(hud: MOHUD) {
        if let errl = hud.errorLabel {
            errl.text = failureString
        }
        if let _lc = hud.loaderContainer {
            _lc.layer.cornerRadius = 10
        }
        if let _sl = hud.statusLabel {
            if self.statusString != "" {
            _sl.text = self.statusString
            }
        }
        if let _tL = hud.titleLabel {
            if self.titleString != "" {
                _tL.text = self.titleString
            }
        }
    }
}
