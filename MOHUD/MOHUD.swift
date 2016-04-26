//
//  MOHUD.swift
//  OnTheMap
//
//  Created by Moath_Othman on 6/27/15.
//  Copyright (c) 2015 Moba. All rights reserved.
//

import UIKit

public class MOHUD: UIViewController {
    static var me:MOHUD?
    //MARK: Outlets
    @IBOutlet weak var loaderContainer: UIVisualEffectView?
    @IBOutlet weak var errorLabel: UILabel?
    @IBOutlet weak var statusLabel: UILabel?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    @IBOutlet weak var buttonsContainer: UIView?
    @IBOutlet weak var continueButton: UIButton?
    @IBOutlet weak var cancelButton: UIButton?
    //MARK: variables
    var statusString: String = ""
    var failureString: String = ""
    var titleString: String = ""
    // Closures
    static var onContinoue: (() -> Void)?
    static var onCancel: (() -> Void)?
    
    override public func viewWillAppear(animated: Bool) {
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
    // MARK: - Public
    // MARK: Subtitle
    /// SHOW SUBTITLE HUD WITH TITLE AND SUBTITLE
    public class func showSubtitle(title title:String, subtitle:String, withCancelAndContinue: Bool = false) {
        MakeSubtitleHUD()
        MOHUD.me?.statusString = subtitle
        MOHUD.me?.titleString = title
        MOHUD.me?.show()
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    /// SHOW SUBTITILE HUD WITH TITLE, SUBTITLE AND CERTAIN AMOUNT OF TIME IN SEC
    public class func showSubtitle(title title:String, subtitle:String, period: NSTimeInterval, withCancelAndContinue: Bool = false) {
        MakeSubtitleHUD()
        MOHUD.me?.statusString = subtitle
        MOHUD.me?.titleString = title
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    //MARK: Fail
    /// SHOW FAILURE HUD WITH MESSAGE
    public class func showWithError(errorString:String) {
        MakeFailureHUD()
        MOHUD.me?.failureString = errorString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: 2)
    }
    /// SHOW FAILURE HUD WITH MESSAGE AND FOR A CERTAIN AMOUNT OF TIME IN SEC
    public class func showWithError(errorString:String, period: NSTimeInterval) {
        MakeFailureHUD()
        MOHUD.me?.failureString = errorString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }
    //MARK: Success
    /// SHOW SUCCESS HUD WITH MESSAGE
    public class func showSuccess(successString: String) {
        MakeSuccessHUD()
        MOHUD.me?.statusString = successString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: 2)
    }
    /// SHOW SUCCESS HUD WITH MESSAGE FOR CERTAIN AMOUNT OF TIME IN SEC
    public class func showSuccess(successString: String, period: NSTimeInterval) {
        MakeSuccessHUD()
        MOHUD.me?.statusString = successString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
    }
    //MARK: Default show
    /// SHOW THE DEFAUL HUD WITH LOADING MESSAGE
    public class func show(withCancelAndContinue: Bool = false) {
        MakeProgressHUD()
        MOHUD.me?.show()
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    /// Show for certain amount of time IN SEC
    public class func show(periodOfTime period: NSTimeInterval, withCancelAndContinue: Bool = false) {
        MakeProgressHUD()
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    /// Show with Status
    public class func showWithStatus(status: String, withCancelAndContinue: Bool = false) {
        MakeProgressHUD()
        MOHUD.me?.statusString = status
        MOHUD.me?.show()
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    /// Show with Status for certain amount of time IN SEC
    public class func showWithStatus(status: String, period: NSTimeInterval, withCancelAndContinue: Bool = false) {
        MakeProgressHUD()
        MOHUD.me?.statusString = status
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: period)
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    //MARK: Show/hide and timer
    private func show() {
        MOHUD.me?.view.alpha = 0;
        MOHUD.onCancel = .None
        MOHUD.onContinoue = .None
        //NOTE: Keywindow should be shown first
        if let keywindow = UIApplication.sharedApplication().keyWindow {
            keywindow.addSubview(self.view)
            UIView.animateWithDuration(1.55, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                MOHUD.me?.view.alpha = 1;
                }) { (finished) -> Void in
                    
            }
        }
    }
    /// Dismiss the HUD
    public class func dismiss() {
        MOHUD.onCancel = nil
        MOHUD.onContinoue = nil
        if let _me = me {
            UIView.animateWithDuration(0.45, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                _me.view.alpha = 0;
                }) { (finished) -> Void in
                _me.view.removeFromSuperview()
                    
            }
        }
    }
    /// Change the Style of the Hud LIGHT/DARK/EXTRALIGHT
    public class func setBlurStyle(style: UIBlurEffectStyle) {
        me?.loaderContainer?.effect = UIBlurEffect(style: style)
        if style == .Dark {
            me?.statusLabel?.textColor = UIColor.whiteColor()
            me?.activityIndicator?.activityIndicatorViewStyle = .WhiteLarge
            
            me?.buttonsContainer?.backgroundColor = UIColor ( red: 0.04, green: 0.0695, blue: 0.061, alpha: 0.6 )
            me?.continueButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            me?.cancelButton?.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        } else {
            me?.statusLabel?.textColor = UIColor.blackColor()
            me?.activityIndicator?.activityIndicatorViewStyle = .Gray
            
            me?.buttonsContainer?.backgroundColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6 )
            me?.continueButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
            me?.cancelButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
    }
    private var hideTimer: NSTimer?
    private func hide(afterDelay delay: NSTimeInterval) {
        hideTimer?.invalidate()
        hideTimer = NSTimer.scheduledTimerWithTimeInterval(delay, target: self.classForCoder, selector: #selector(MOHUD.dismiss), userInfo: nil, repeats: false)
    }
    
   
}
// MARK: - IBActions
extension MOHUD {
    @IBAction private func hideHud(sender: AnyObject? = nil) {
        MOHUD.dismiss()
    }
    @IBAction func cancelProcess(sender: AnyObject) {
        MOHUD.onCancel?()
        hideHud()
    }
    @IBAction func continueWithoutCancelling(sender: AnyObject) {
        MOHUD.onContinoue?()
        hideHud()
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
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "MOHUD", bundle: NSBundle(forClass: MOHUD.self))
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
        hud.errorLabel?.text = failureString
        hud.loaderContainer?.layer.cornerRadius = 10
        if self.statusString != "" {
            hud.statusLabel?.text = self.statusString
        }
        if self.titleString != "" {
            hud.titleLabel?.text = self.titleString
            hud.titleLabel?.adjustsFontSizeToFitWidth = true
        }
        buttonsContainer?.layer.cornerRadius = 5
    }
}
