//
//  UIView.swift
//  GTHubPlay
//
//  Created by Sanjay Shah on 18/08/18.
//  Copyright © 2018 GTHub. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable
    var circleView: Bool {
        get {
            return true
        }
        set {
            layer.cornerRadius = self.frame.height / 2
            clipsToBounds = true
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    //=======================================================================
    // MARK:- Load View From Nib
    //=======================================================================

    func loadViewFromNib() {
        
        let nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
        let view = Bundle(for: type(of: self)).loadNibNamed(nibName, owner: self, options: nil)?.first as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let views = ["view": view]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views))
        setNeedsUpdateConstraints()
    }
}

extension UIView {
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *){
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}
extension UIView {
    
    /// Removes specified set of constraints from the views in the receiver's subtree and from the receiver itself.
    ///
    /// - parameter constraints: A set of constraints that need to be removed.
    func removeConstraintsFromSubtree(_ constraints: Set<NSLayoutConstraint>) {
        var constraintsToRemove = [NSLayoutConstraint]()
        
        for constraint in self.constraints {
            if constraints.contains(constraint) {
                constraintsToRemove.append(constraint)
            }
        }
        
        self.removeConstraints(constraintsToRemove)
        
        for view in self.subviews {
            view.removeConstraintsFromSubtree(constraints)
        }
    }
    
}
extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}
extension UIViewController {
  func alert(message: String, title: String = "TTS") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
}

let textToSpoke = """
            About Project
                •    At KOVA Corporation, we are all about communication.
                •    Our public safety solutions enable 911 call centers to function more efficiently, allow emergency responders to instantly share vital information, and make it possible to record and decipher data gathered.
                •    Our enterprise workforce optimization solutions help organizations boost employee performance and customer service in their contact centers.
                •    And our SilentPartner app allows emergency responders and mobile professionals alike to maintain a constant flow of data between their smartphone and their office database.
                •    Silent Partner (Kova) is a Mobile Application to record all kinds of dictations/recordings and sync with the central server.
                •    The platform have 2 interfaces:
                •    End-user Mobile Applications
                •    Admin Panel (Web-based)
                •    The end-users can record dictation audio, select and save images and videos from the gallery, capture Miranda, Call interviewee and record calls using mobile application. The application allows users to call over IP (VOIP).
            Features
            User Features
                •    Login with a paid license key alloted by the kova company to organizations.
                •    Users can access a menu which includes List of Recordings, Dictation, Upload Media, Cases, Miranda, Settings,SIP Call, Translator, About Us modules.
                •    Users can access a list of recordings at the main page, Filter it by Sip-calls and dictation.
                •    Interviewer records dictation audio with the interviewee and saves it for a case number.
                •    Users can select some important documents from the gallery.
                •    Users can add and update case numbers in cases module.
                •    Devices with access to camera and microphone can record miranda which basically records video along with interactive audio instructions. You can imagine a criminal case here and a situation when policemen interview the criminal which is being recorded as Miranda.
                •    One default number can be saved as a translator's number from settings or even can be updated from the admin panel. Which can be used to call the translator instantly.
                •    SIP-Call - Interviewer can call interviewee using extension number provided and record their conversation over call. This call happens over IP.
                •    Users can access settings with a password set by the admin. Some settings can be changed from the admin panel.
                •    Letter all the recording will be synced with the FTP server at kova organization.

            Backend Features

                •    Push notification API implementation in node to support sip call.
                •    Set up asterisk test server for sip calling features.

            Technology
                •    Swift (v - 5.0)
                •    Asterisk (SIP Call Management server) (v - 16.5.0)
                •    Kotlin (v - 1.3)
                •    Android Studio
                •    Xcode  (v - 11)
                •    Node (v - 10.16.3)

            Domain
            Communications

            Major Challenges
                •    Understanding SIP Protocol
                •    Pjsip library and implementation complexity.
                •    Recording call and manipulating pjsip libs.
                •    Accurate calling feature and playing beep sound during call.
                •    Asterisk server implementation and testing with it.
                •    Silent Notification in iOS and Android to receive calls even when the app is killed.
            """
