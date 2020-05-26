//
//  SettingsVC.swift
//  OffLineSpeechtoText
//
//  Created by Paresh Prajapati on 07/05/20.
//  Copyright © 2020 SolutionAnalysts. All rights reserved.
//

import UIKit
import AVFoundation


protocol SettingSelectionDelegate: class {
    func didSelectVoice(voice: AVSpeechSynthesisVoice?, rate: Float, pitch: Float, postDelay: Double, preDelay: Double)
    
    func didCancel()
}

class SettingsVC: UIViewController {

    @IBOutlet weak var lblPostUDealy: UILabel!
    @IBOutlet weak var stpeerPostUDelay: UIStepper!
    @IBOutlet weak var lblPreUDelay: UILabel!
    @IBOutlet weak var stepperPreUDelay: UIStepper!
    @IBOutlet weak var lblPitch: UILabel!
    @IBOutlet weak var stepperPitch: UIStepper!
    @IBOutlet weak var stepperRate: UIStepper!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var tblVoices: UITableView!
    var selectedRate:Float = 0.0
    var selectedPitch:Float = 0.0
    var selectedPreDelay:Double = 0
    var selectedPostDelay:Double = 0
    var voices: [AVSpeechSynthesisVoice] = []
    var selectedVoice: AVSpeechSynthesisVoice?
    weak var delegate:SettingSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
        let speechVoices = AVSpeechSynthesisVoice.speechVoices()
        self.voices = speechVoices
        self.tblVoices.reloadData()
    }
    
    func setDefaults() {
        stepperRate.value = Double(selectedRate)
        lblRate.text = String(format: "%.2f", selectedRate)
        
        stepperPitch.value = Double(selectedPitch)
        lblPitch.text = String(format: "%.2f", selectedPitch)
        
        stepperPreUDelay.value = Double(selectedPreDelay)
        lblPreUDelay.text = String(format: "%.2f", selectedPreDelay)
         
        stpeerPostUDelay.value = Double(selectedPostDelay)
        lblPostUDealy.text = String(format: "%.2f", selectedPostDelay)
    }
    
    @IBAction func btnCloseTouched(_ sender: Any) {
        self.delegate?.didCancel()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rateStepperChanged(_ sender: Any) {
        
        let newValue = stepperRate.value
        selectedRate = Float(newValue)
        lblRate.text = String(format: "%.2f", newValue)
    }
    
    @IBAction func pitchStepperChanged(_ sender: Any) {
        let newValue = stepperPitch.value
        selectedPitch = Float(newValue)
        lblPitch.text = String(format: "%.2f", newValue)
    }
    
    @IBAction func preUDelayChanged(_ sender: Any) {
        let newValue = stepperPreUDelay.value
        selectedPreDelay = newValue
        lblPreUDelay.text = String(format: "%.2f", newValue)
    }
    
    @IBAction func postUDelayChanged(_ sender: Any) {
        let newValue = stpeerPostUDelay.value
        selectedPostDelay = newValue
        lblPostUDealy.text = String(format: "%.2f", newValue)
    }
    
    @IBAction func btnDoneTouched(_ sender: Any) {
        delegate?.didSelectVoice(voice: selectedVoice, rate: selectedRate, pitch: selectedPitch, postDelay: selectedPostDelay, preDelay: selectedPreDelay)
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoicePersonCell", for: indexPath) as! VoicePersonCell
        cell.lblName.text = "\(self.voices[indexPath.row].name)\(self.voices[indexPath.row].language)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVoice = voices[indexPath.row]
    }
    
    
}

