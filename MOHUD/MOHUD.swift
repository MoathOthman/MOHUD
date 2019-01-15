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
open class MOHUD: UIViewController {
    
    /// Responsible for showing and hiding the hud
    var hudstage: HUDStage!
    
    static var me:MOHUD? {
        didSet {
            if let _m = me {
                _m.hudstage = HUDStage(view: _m)
            }
        }
    }
    
    //MARK: Outlets
    @IBOutlet var loaderContainer: UIVisualEffectView?
    @IBOutlet var errorLabel: UILabel?
    @IBOutlet var statusLabel: UILabel?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var activityIndicator: UIActivityIndicatorView?
    @IBOutlet var buttonsContainer: UIView?
    @IBOutlet var continueButton: UIButton?
    @IBOutlet var cancelButton: UIButton?
    @IBOutlet var successLabcel: UILabel?
    @IBOutlet var subTitleLabel: UILabel?
    
    // Closures
    /// executed when user taps on Continue button
    public static var onContinoue: (() -> Void)?
    /// executed when user taps on Cancel button
    public static var onCancel: (() -> Void)?
    /// viewwillappear override
    override open func viewWillAppear(_ animated: Bool) {
        if MOHUD.me != nil {
            self.commonSetup(MOHUD.me!)
        }
    }
    
    //MARK: Constructor
    class func ME(_ _me:MOHUD?) {
        me = _me
    }
    
    //MARK: Factory
    class func MakeProgressHUD() {
        ME(self.make(.progress))
    }
    class func MakeSuccessHUD() {
        ME(self.make(.success))
    }
    class func MakeFailureHUD() {
        ME(self.make(.failure))
    }
    class func MakeSubtitleHUD() {
        ME(self.make(.subtitle))
    }
    // MARK: - Public
    // MARK: Subtitle
    /// SHOW SUBTITLE HUD WITH TITLE AND SUBTITLE
    open class func showSubtitle(title:String, subtitle:String, withCancelAndContinue: Bool = false) {
        MOHUD.dismissWith(animated: false) {
            MakeSubtitleHUD()
            MOHUDTexts.subtitleStyleSubtitlePleaseWait = subtitle
            MOHUDTexts.subtitleStyleTitleConnecting = title
            MOHUD.me?.show()
            me?.buttonsContainer?.isHidden = !withCancelAndContinue
        }
    }
    //MARK: Fail
    /// SHOW FAILURE HUD WITH MESSAGE
    open class func showWithError(_ errorString:String) {
        MOHUD.dismissWith(animated: false) {
            MakeFailureHUD()
            MOHUDTexts.errorTitle = errorString
            MOHUD.me?.show()
            MOHUD.me?.hide(afterDelay: 2)
        }
    }
    //MARK: Success
    /// SHOW SUCCESS HUD WITH MESSAGE
    open class func showSuccess(_ successString: String) {
        MOHUD.dismissWith(animated: false) {
            MakeSuccessHUD()
            MOHUDTexts.successTitle = successString
            MOHUD.me?.show()
            MOHUD.me?.hide(afterDelay: 2)
        }
    }
    //MARK: Default show
    /// SHOW THE DEFAUL HUD WITH LOADING MESSAGE
    open class func show(_ withCancelAndContinue: Bool = false) {
        MOHUD.dismissWith(animated: false) {
            MakeProgressHUD()
            MOHUD.me?.show()
            me?.buttonsContainer?.isHidden = !withCancelAndContinue
        }
    }
    /// Show with Status
    open class func showWithStatus(_ status: String, withCancelAndContinue: Bool = false) {
        MOHUD.dismissWith(animated: false) { _ in
            MakeProgressHUD()
            MOHUDTexts.defaultLoadingTitle = status
            MOHUD.me?.show()
            me?.buttonsContainer?.isHidden = !withCancelAndContinue
        }
    }
    
    /// Dismiss the HUD
    open class func dismiss() {
        dismissWith {}
    }
    
    open class func dismissWith(animated: Bool = true, completed: @escaping () -> Void) {
        MOHUD.me?.hudstage.hide()
        completed()
    }
    //MARK: Show/hide and timer
    fileprivate func show() {
        hudstage = HUDStage(view: MOHUD.me!)
        hudstage.show()
    }
    
    /// Change the Style of the Hud LIGHT/DARK/EXTRALIGHT
    open class func setBlurStyle(_ style: UIBlurEffectStyle) {
        me?.loaderContainer?.effect = UIBlurEffect(style: style)
        let isDark = style == .dark
        let darkColor =  UIColor ( red: 0.04, green: 0.0695, blue: 0.061, alpha: 0.6 )
        let lightColor = UIColor ( red: 1.0, green: 1.0, blue: 1.0, alpha: 0.6 )
        me?.subTitleLabel?.textColor = isDark ? UIColor.white : UIColor.black
        me?.statusLabel?.textColor = isDark ? UIColor.white : UIColor.black
        me?.titleLabel?.textColor = isDark ? UIColor.white : UIColor.black
        me?.activityIndicator?.activityIndicatorViewStyle = isDark ? .whiteLarge : .gray
        me?.buttonsContainer?.backgroundColor = isDark ? darkColor : lightColor
        me?.continueButton?.setTitleColor(isDark ? UIColor.white : UIColor.black, for: UIControlState())
        me?.cancelButton?.setTitleColor(isDark ? UIColor.white : UIColor.black, for: UIControlState())
    }
    /// hide Timer used when waiting for a hud to hide
    public static func hideAfter(_ delay: TimeInterval) {
        MOHUD.me?.hide(afterDelay: delay)
    }
    
    fileprivate var hideTimer: Timer?
    fileprivate func hide(afterDelay delay: TimeInterval) {
        hideTimer?.invalidate()
        hideTimer = Timer.scheduledTimer(timeInterval: delay, target: self.classForCoder, selector: #selector(MOHUD.dismiss), userInfo: nil, repeats: false)
    }
}

// MARK: - IBActions
extension MOHUD {
    @IBAction fileprivate func hideHud(_ sender: AnyObject? = nil) {
        MOHUD.dismiss()
    }
    @IBAction func cancelProcess(_ sender: AnyObject) {
        MOHUD.onCancel?()
        hideHud()
    }
    @IBAction func continueWithoutCancelling(_ sender: AnyObject) {
        MOHUD.onContinoue?()
        hideHud()
    }
}

extension MOHUD {
    func commonSetup(_ hud: MOHUD) {
        hud.titleLabel?.adjustsFontSizeToFitWidth = true
        // Set labels texts
        hud.errorLabel?.text = MOHUDTexts.errorTitle
        hud.titleLabel?.text = MOHUDTexts.subtitleStyleTitleConnecting
        hud.subTitleLabel?.text = MOHUDTexts.subtitleStyleSubtitlePleaseWait
        hud.successLabcel?.text = MOHUDTexts.successTitle
        hud.continueButton?.setTitle(MOHUDTexts.continueButtonTitle, for: UIControlState())
        hud.cancelButton?.setTitle(MOHUDTexts.cancelButtonTitle, for: UIControlState())
        hud.statusLabel?.text = MOHUDTexts.defaultLoadingTitle
    }
}

// MARK: - UTILITIES

/// set of view inpectables
extension UIView {
    /// border color inspectable prop.
    @IBInspectable public var borderColor: UIColor  {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
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
    class func make(_ type : MOSceneType) -> MOHUD? {
        let mainStoryBoard: UIStoryboard = UIStoryboard(name: "MOHUD", bundle: Bundle(for: MOHUD.self))
        switch type {
        case .progress:
            return mainStoryBoard.instantiateViewController(withIdentifier: MOStoryBoardID.progress) as? MOHUD
        case .success:
            return mainStoryBoard.instantiateViewController(withIdentifier: MOStoryBoardID.success) as? MOHUD
        case .failure:
            return mainStoryBoard.instantiateViewController(withIdentifier: MOStoryBoardID.failure) as? MOHUD
        case .subtitle:
            return mainStoryBoard.instantiateViewController(withIdentifier: MOStoryBoardID.subtitle) as? MOHUD
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
    fileprivate static func resetDefaults() {
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
    
    fileprivate struct MOHUDDefaultTexts {
        static var continueButtonTitle = NSLocalizedString("Continue", comment: "Continue button label")
        static var cancelButtonTitle = NSLocalizedString("Cancel", comment: "Cancel button label")
        static var defaultLoadingTitle = NSLocalizedString("Loading", comment: "Normal Loading label")
        
        static var subtitleStyleTitleConnecting = NSLocalizedString("Connecting", comment: "Subtitle type Title Text")
        static var subtitleStyleSubtitlePleaseWait = NSLocalizedString("Please wait", comment: "Subtitle type subTitle Text")
        
        static var successTitle = NSLocalizedString("Success", comment: "Success HUD Label Default Text")
        static var errorTitle = NSLocalizedString("Error", comment: "Error HUD Label Default Text")
    }
}

/// handle where and when to show the HUD
class HUDStage {
    unowned let view: UIViewController
    private var window: UIWindow?
    init(view: UIViewController) {
        self.view = view
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = view
    }
    
    func show() {
        window?.windowLevel = UIWindowLevelAlert + 1
        window?.makeKeyAndVisible()
    }
    
    func hide() {
        window?.isHidden = true
        window = nil
    }
}

