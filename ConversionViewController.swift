//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Zack Falgout on 5/2/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit


class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
    var fahrenheitValue: Measurement<UnitTemperature>?{
        didSet{
            updateCelsiusLabel()
        }
    }
    var celsiusValue: Measurement<UnitTemperature>?{
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    let numberFormatter : NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ConversionViewController loaded it's view")
        
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let hour = Calendar.current.component(.hour, from: Date())
        let cal = Calendar(identifier: .gregorian)
        let lateHour = cal.startOfDay(for: Date())
        
        if (hour < 20){
            self.view.backgroundColor = UIColor.gray
        } else {
            self.view.backgroundColor = UIColor.blue
        }
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue{
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        let replacementStringHasLetters = string.rangeOfCharacter(from: NSCharacterSet.letters)
        
        if ((existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || replacementStringHasLetters != nil) {
            return false
        } else {
            return true
        }
        
    }
    
    @IBAction func farenheitFieldEditingChanged(_ textField: UITextField){
       celsiusLabel.text = textField.text
        

        if let text = textField.text, let number = numberFormatter.number(from: text){
            fahrenheitValue = Measurement(value: number.doubleValue, unit: .fahrenheit)
        } else {
            fahrenheitValue = nil
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
}
