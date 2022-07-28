//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    var tipSelected = 0.1
    var tipPercentage: String!
    var totalBill: Double?
    var splitBetween = 2.0
    var totalEach: Double?
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!

    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        tipPercentage = sender.currentTitle ?? "10%"
        
        if sender.currentTitle == "0%" {
            zeroPctButton.isSelected = true
            tipSelected = 0.0
        } else if sender.currentTitle == "10%" {
            tenPctButton.isSelected = true
            tipSelected = 0.1
        } else {
            twentyPctButton.isSelected = true
            tipSelected = 0.2
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        totalBill = Double(billTextField.text!) ?? 0.00
        splitBetween = Double(splitNumberLabel.text!)!
        totalEach = (totalBill! * (tipSelected + 1)) / splitBetween
                
        self.performSegue(withIdentifier: "goToResults", sender: self)
        billTextField.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalEach = totalEach
            destinationVC.splitBetween = splitBetween
            destinationVC.tipPercentage = tipPercentage
        }
    }
    
}

