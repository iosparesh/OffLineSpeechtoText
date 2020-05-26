//
//  HTDTextView.swift
//  HTDriverApp
//
//  Created by paresh on 09/04/20.
//  Copyright © 2020 Sanjay Shah. All rights reserved.
//

import UIKit
protocol HTDTextFieldDelegate: class {
    func HTDTextField(textFiled: UITextField, didChange text: String)
}

@IBDesignable
class HTDTextView: UIView {
    
    weak var delegate: HTDTextFieldDelegate?
    private var textField: UITextField!
    private var imgIcon: UIImageView!
    private var viewUnderLine: UIView!
    private var rightimgIcon: UIButton!
    private var mendatoryImgStar: UIImageView!
    private var messageLabel: UILabel!
    var heightMessageLabel: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeWithUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeWithUI()
        setConstraint()
        setDefaultValues()
    }
    
    deinit {
        print("Did Deinitialize the textfield")
    }
    
    private func initializeWithUI() {
        mendatoryImgStar = UIImageView()
        mendatoryImgStar.tintColor = UIColor.black
        backgroundColor = UIColor.clear
        imgIcon = UIImageView()
        imgIcon.tintColor = UIColor.black
        rightimgIcon = UIButton(frame: CGRect.zero)
        viewUnderLine = UIView()
        textField = UITextField()
        imgIcon.contentMode = .center
        rightimgIcon.contentMode = .center
        viewUnderLine.backgroundColor = UIColor.gray
        
        messageLabel = UILabel(frame: CGRect.zero)
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        
        
        
        self.addSubview(imgIcon)
//        self.addSubview(mendatoryImgStar)
        self.addSubview(textField)
        self.addSubview(rightimgIcon)
        self.addSubview(viewUnderLine)
        self.addSubview(messageLabel)
        layoutSubviews()
    }
    
    func setDefaultValues() {
        textField.font = UIFont.systemFont(ofSize: 14)
        messageLabel.font = UIFont.systemFont(ofSize: 14)
        textField.delegate = self
        isSecure = false
        rightimgIcon.addTarget(self, action: #selector(rightIconButtonTopuched), for: .touchUpInside)
    }
    
    @objc func rightIconButtonTopuched(sender: UIButton) {
        textField.isSecureTextEntry = !textField.isSecureTextEntry
    }
    
    @IBInspectable var placeHolder: String = "Place Holder" {
        didSet {
            textField.placeholder = NSLocalizedString(placeHolder, comment: "")
        }
    }
    
    @IBInspectable var leftIcon: UIImage? {
        didSet {
            imgIcon.image = leftIcon
        }
    }
    
    @IBInspectable var starIcon: UIImage? {
        didSet {
            mendatoryImgStar.image = starIcon
        }
    }
    
    @IBInspectable var rightIcon: UIImage? {
        didSet {
            rightimgIcon.setImage(rightIcon, for: .normal)
        }
    }
    
    public var keyboard: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboard
        }
    }
    
    func setText(_ text: String) {
        textField.text = text
    }
    
    func setMessageText(_ text: String) {
        messageLabel.text = text
        if text == "" {
            heightMessageLabel.constant = 0
        } else {
            heightMessageLabel.constant = 50
        }
        self.layoutSubviews()
    }
    
    public var messageText: String? {
        guard messageLabel != nil else {
            return nil
        }
        return messageLabel.text
    }
    
    public var text: String {
        return textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    var isSecure: Bool {
        get {
            return textField.isSecureTextEntry
        }
        set {
            textField.isSecureTextEntry = newValue
        }
    }
    
    private func setConstraint() {
        self.translatesAutoresizingMaskIntoConstraints = false
        imgIcon.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        rightimgIcon.translatesAutoresizingMaskIntoConstraints = false
        viewUnderLine.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        mendatoryImgStar.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingLeftIocn = NSLayoutConstraint(item: imgIcon!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let widthLeftIcon = NSLayoutConstraint(item: imgIcon!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let heightLeftIcon = NSLayoutConstraint(item: imgIcon!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        let top = NSLayoutConstraint(item: imgIcon!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        let trailingLeftIocn = NSLayoutConstraint(item: imgIcon!, attribute: .trailing, relatedBy: .equal, toItem: textField, attribute: .leading, multiplier: 1, constant: 0)
        
        let centerVerticle = NSLayoutConstraint(item: imgIcon!, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1, constant: 0)
        
        let topTextField = NSLayoutConstraint(item: textField!, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        
        let trailingTextfield = NSLayoutConstraint(item: textField!, attribute: .trailing, relatedBy: .equal, toItem: rightimgIcon!, attribute: .leading, multiplier: 1, constant: 0)
        
        let trailingRightIcon = NSLayoutConstraint(item: rightimgIcon!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        
        let widthRightIcon = NSLayoutConstraint(item: rightimgIcon!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        let heightRightIcon = NSLayoutConstraint(item: rightimgIcon!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        
        let topline = NSLayoutConstraint(item: viewUnderLine!, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 4.5)
    
        let leadingLine = NSLayoutConstraint(item: viewUnderLine!, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let trailingLine = NSLayoutConstraint(item: viewUnderLine!, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let heightTextfield = NSLayoutConstraint(item: textField!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        let heightLine = NSLayoutConstraint(item: viewUnderLine!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0.5)
        
        let topMessage = NSLayoutConstraint(item: messageLabel!, attribute: .top, relatedBy: .equal, toItem: viewUnderLine, attribute: .bottom, multiplier: 1, constant: 4.5)
        let bottomline = NSLayoutConstraint(item: messageLabel!, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        let leadingMessage = NSLayoutConstraint(item: messageLabel!, attribute: .leading, relatedBy: .equal, toItem: viewUnderLine, attribute: .leading, multiplier: 1, constant: 0)
        let trailingMessage = NSLayoutConstraint(item: messageLabel!, attribute: .trailing, relatedBy: .equal, toItem: viewUnderLine, attribute: .trailing, multiplier: 1, constant: 0)
        
        heightMessageLabel = NSLayoutConstraint(item: messageLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        
         self.addConstraints([leadingLeftIocn, top, widthLeftIcon, heightLeftIcon, heightRightIcon, widthRightIcon, topTextField, topline, trailingLeftIocn, trailingTextfield, trailingRightIcon, leadingLine, trailingLine, heightLine, bottomline, heightTextfield,leadingMessage,trailingMessage, topMessage, heightMessageLabel])
    }
}
extension HTDTextView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            delegate?.HTDTextField(textFiled: textField, didChange: updatedText)
        }
        return true
    }
}
