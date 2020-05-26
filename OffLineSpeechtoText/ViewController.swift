//
//  ViewController.swift
//  OffLineSpeechtoText
//
//  Created by Paresh Prajapati on 06/05/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var btnStop: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var txtViewUtterance: UITextView!
    let avSpeechSynthesizer = AVSpeechSynthesizer()
    var rate = AVSpeechUtteranceDefaultSpeechRate
    var pitchMultiplier:Float = 0.5
    var preDelay:Double = 0
    var postDelay:Double = 0
    var selectedVoice: AVSpeechSynthesisVoice!
    let lang = "en-US"
    override func viewDidLoad() {
        super.viewDidLoad()
        let mutableString = NSMutableAttributedString(string: textToSpoke)
        mutableString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20)], range: NSRange(textToSpoke)!)
        txtViewUtterance.attributedText = mutableString
        selectedVoice = AVSpeechSynthesisVoice(language: lang)
        btnStop.isHidden = true
        avSpeechSynthesizer.delegate = self
    }
    
    @IBAction func btnStopTouched(_ sender: Any) {
        if avSpeechSynthesizer.isSpeaking || avSpeechSynthesizer.isPaused {
            avSpeechSynthesizer.stopSpeaking(at: .immediate)
            btnStop.isHidden = true
            btnStart.setTitle("Start", for: .normal)
        }
    }
    
    @IBAction func btnSettingsTouched(_ sender: Any) {
        if avSpeechSynthesizer.isSpeaking {
            self.alert(message: "Please stop current speech first.")
            return
        }
        let settings = self.storyboard?.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsVC
        settings.modalPresentationStyle = .overCurrentContext
        settings.isModalInPresentation = true
        settings.delegate = self
        settings.selectedRate = self.rate
        settings.selectedVoice = self.selectedVoice
        settings.selectedPitch = pitchMultiplier
        settings.selectedPostDelay = postDelay
        settings.selectedPreDelay = preDelay
        self.present(settings, animated: true, completion: nil)
    }
    @IBAction func buttonStartSpeech(_ sender: Any) {
        
        if avSpeechSynthesizer.isPaused {
            avSpeechSynthesizer.continueSpeaking()
            btnStart.setTitle("Pause", for: .normal)
            return
        }
        
        if avSpeechSynthesizer.isSpeaking {
            avSpeechSynthesizer.pauseSpeaking(at: .word)
            btnStart.setTitle("Resume", for: .normal)
            return
        }
        
        btnStart.setTitle("Pause", for: .normal)
        btnStop.isHidden = false
        avSpeechSynthesizer.speak(getUtteranceWithDelay(preUtteranceDelayInSecond: 1, postUtteranceDelayInSecond: 2))
        avSpeechSynthesizer.speak(getUtteranceWithDelay(preUtteranceDelayInSecond: 1, postUtteranceDelayInSecond: 2))
    }
    
    func getUtterance(_ speechString: String) -> AVSpeechUtterance {
        let utterance = AVSpeechUtterance(string: speechString)
        utterance.voice = selectedVoice
        utterance.rate = self.rate
        utterance.pitchMultiplier = self.pitchMultiplier
        utterance.volume = 0.5
        return utterance
    }
    
    func getUtteranceWithDelay(preUtteranceDelayInSecond: Int, postUtteranceDelayInSecond: Int) -> AVSpeechUtterance {
        let utterance = getUtterance(self.txtViewUtterance.text)
         utterance.preUtteranceDelay = preDelay
         utterance.postUtteranceDelay = postDelay
        return utterance
    }
}

extension ViewController: AVSpeechSynthesizerDelegate {
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) { }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didPause utterance: AVSpeechUtterance) { }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didContinue utterance: AVSpeechUtterance) {
        txtViewUtterance.attributedText = NSAttributedString(string: utterance.speechString)
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) { }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {
        DispatchQueue.main.async {
            let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
            mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)
            self.txtViewUtterance.attributedText = mutableAttributedString
            self.txtViewUtterance.scrollRangeToVisible(characterRange)
        }
    }
}
extension ViewController: SettingSelectionDelegate {
    func didSelectVoice(voice: AVSpeechSynthesisVoice?, rate: Float, pitch: Float, postDelay: Double, preDelay: Double) {
        self.rate = rate
        self.selectedVoice = voice == nil ? AVSpeechSynthesisVoice(language: lang) : voice
        self.pitchMultiplier = pitch
        self.preDelay = preDelay
        self.postDelay = postDelay
    }
    
    func didCancel() {
        
    }
    
    
}
