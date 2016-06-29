//  MOHUD.swift
//  Created by Moath_Othman on 6/27/15.

import UIKit
/**
 MOHUD
 Simple HUD the looks like the Mac status alert view .
 can be used to indicate a process, like API request, and for status, like Success and failure.
 and you can add continue and cancel handlers so user can cancel the request or continue without blocking the screen.
 
 @auther Moath OTjman
 */
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
    @IBOutlet weak var successLabcel: UILabel?
    @IBOutlet weak var subTitleLabel: UILabel?
    
    // Closures
    /// executed when user taps on Continue button
    public static var onContinoue: (() -> Void)?
    /// executed when user taps on Cancel button
    public static var onCancel: (() -> Void)?
    /// viewwillappear override
    override public func viewWillAppear(animated: Bool) {
        if MOHUD.me != nil {
            self.commonSetup(MOHUD.me!)
        }
    }
    //MARK: Constructor
    class func ME(_me:MOHUD?) -> MOHUD?{
//        dismiss() // if any there dismiss it
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
        MOHUDTexts.subtitleStyleSubtitlePleaseWait = subtitle
        MOHUDTexts.subtitleStyleTitleConnecting = title
        MOHUD.me?.show()
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    //MARK: Fail
    /// SHOW FAILURE HUD WITH MESSAGE
    public class func showWithError(errorString:String) {
        MakeFailureHUD()
        MOHUDTexts.errorTitle = errorString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: 2)
    }
    //MARK: Success
    /// SHOW SUCCESS HUD WITH MESSAGE
    public class func showSuccess(successString: String) {
        MakeSuccessHUD()
        MOHUDTexts.successTitle = successString
        MOHUD.me?.show()
        MOHUD.me?.hide(afterDelay: 2)
    }
    //MARK: Default show
    /// SHOW THE DEFAUL HUD WITH LOADING MESSAGE
    public class func show(withCancelAndContinue: Bool = false) {
        MakeProgressHUD()
        MOHUD.me?.show()
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    /// Show with Status
    public class func showWithStatus(status: String, withCancelAndContinue: Bool = false) {
        MakeProgressHUD()
        MOHUDTexts.defaultLoadingTitle = status
        MOHUD.me?.show()
        me?.buttonsContainer?.hidden = !withCancelAndContinue
    }
    /// Dismiss the HUD
    public class func dismiss() {
//        MOHUD.onCancel = nil
//        MOHUD.onContinoue = nil
//        MOHUDTexts.resetDefaults()
        if let _me = me {
            UIView.animateWithDuration(0.45, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                _me.view.alpha = 0;
            }) { (finished) -> Void in
                _me.view.removeFromSuperview()
                
            }
        }
    }
    
    //MARK: Show/hide and timer
    private func show() {
        MOHUD.me?.view.alpha = 0;
        //NOTE: Keywindow should be shown first
        if let keywindow = UIApplication.sharedApplication().windows.last {
            keywindow.addSubview(self.view)
            UIView.animateWithDuration(1.55, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                MOHUD.me?.view.alpha = 1;
                }) { (finished) -> Void in
                    
            }
        }
    }
   
    /// Change the Style of the Hud LIGHT/DARK/EXTRALIGHT
    public class func setBlurStyle(style: UIBlurEffectStyle) {
        me?.loaderContainer?.effect = UIBlurEffect(style: style)
        let isDark = style == .Dark
        let darkColor =  UIColor ( red: 0.04, green: 0.0695, blue: 0.061, alpha: 0.6 )
        let lightColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6 )
        me?.subTitleLabel?.textColor = isDark ? UIColor.whiteColor() : UIColor.blackColor()
        me?.statusLabel?.textColor = isDark ? UIColor.whiteColor() : UIColor.blackColor()
        me?.titleLabel?.textColor = isDark ? UIColor.whiteColor() : UIColor.blackColor()
        me?.activityIndicator?.activityIndicatorViewStyle = isDark ? .WhiteLarge : .Gray
        me?.buttonsContainer?.backgroundColor = isDark ? darkColor : lightColor
        me?.continueButton?.setTitleColor(isDark ? UIColor.whiteColor() : UIColor.blackColor(), forState: .Normal)
        me?.cancelButton?.setTitleColor(isDark ? UIColor.whiteColor() : UIColor.blackColor(), forState: .Normal)
    }
    /// hide Timer used when waiting for a hud to hide
    public static func hideAfter(delay: NSTimeInterval) {
        MOHUD.me?.hide(afterDelay: delay)
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

extension MOHUD {
    func commonSetup(hud: MOHUD) {
        hud.titleLabel?.adjustsFontSizeToFitWidth = true
        // Set labels texts
        hud.errorLabel?.text = MOHUDTexts.errorTitle
        hud.titleLabel?.text = MOHUDTexts.subtitleStyleTitleConnecting
        hud.subTitleLabel?.text = MOHUDTexts.subtitleStyleSubtitlePleaseWait
        hud.successLabcel?.text = MOHUDTexts.successTitle
        hud.continueButton?.setTitle(MOHUDTexts.continueButtonTitle, forState: .Normal)
        hud.cancelButton?.setTitle(MOHUDTexts.cancelButtonTitle, forState: .Normal)
        hud.statusLabel?.text = MOHUDTexts.defaultLoadingTitle
    }
}

// MARK: - UTILITIES

/// set of view inpectables
extension UIView {
    /// border color inspectable prop.
    @IBInspectable public var borderColor: UIColor  {
        set {
            self.layer.borderColor = newValue.CGColor
        }
        get {
            return UIColor(CGColor: self.layer.borderColor!)
        }
    }
    /// modify self.layer.borderWidth
    @IBInspectable public var borderWidth: CGFloat   {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    /// modify self.cornerRadius and set clipsTobounds to true
    @IBInspectable public var cornerRadius: CGFloat  {
        set {
            self.layer.cornerRadius = newValue
            self.clipsToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
}


//MARK: - Scenses organizing
//MARK: -

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
/**
 Default Texts Used by the HUDs
 These Can be changed before showing the HUD.
 They are also localization ready .
 @auther Moath Othman
 */

public struct MOHUDTexts {
    public static var continueButtonTitle = MOHUDDefaultTexts.continueButtonTitle
    public static var cancelButtonTitle = MOHUDDefaultTexts.cancelButtonTitle
    public static var defaultLoadingTitle = MOHUDDefaultTexts.defaultLoadingTitle
    
    public static var subtitleStyleTitleConnecting = MOHUDDefaultTexts.subtitleStyleTitleConnecting
    public static var subtitleStyleSubtitlePleaseWait = MOHUDDefaultTexts.subtitleStyleSubtitlePleaseWait
    
    public static var successTitle = MOHUDDefaultTexts.successTitle
    public static var errorTitle = MOHUDDefaultTexts.errorTitle
    /// mark texts to be reset to their default value after the HUD is dismissed
    public static var isResetable = true
    
    /// reset To Defaults if the texts are resettable
    private static func resetDefaults() {
        if isResetable {
            continueButtonTitle = MOHUDDefaultTexts.continueButtonTitle
            cancelButtonTitle = MOHUDDefaultTexts.cancelButtonTitle
            defaultLoadingTitle = MOHUDDefaultTexts.defaultLoadingTitle
            subtitleStyleTitleConnecting = MOHUDDefaultTexts.subtitleStyleTitleConnecting
            subtitleStyleSubtitlePleaseWait = MOHUDDefaultTexts.subtitleStyleSubtitlePleaseWait
            successTitle = MOHUDDefaultTexts.successTitle
            errorTitle = MOHUDDefaultTexts.errorTitle
        }
    }
    
    private struct MOHUDDefaultTexts {
        
        static var continueButtonTitle = NSLocalizedString("Continue", comment: "Continue button label")
        static var cancelButtonTitle = NSLocalizedString("Cancel", comment: "Cancel button label")
        static var defaultLoadingTitle = NSLocalizedString("Loading", comment: "Normal Loading label")
        
        static var subtitleStyleTitleConnecting = NSLocalizedString("Connecting", comment: "Subtitle type Title Text")
        static var subtitleStyleSubtitlePleaseWait = NSLocalizedString("Please wait", comment: "Subtitle type subTitle Text")
        
        static var successTitle = NSLocalizedString("Success", comment: "Success HUD Label Default Text")
        static var errorTitle = NSLocalizedString("Error", comment: "Error HUD Label Default Text")
    }
}
