//
//  ShareTheBillVC.swift
//  ShareTheBill
//
//  Created by Pedro Pereirinha on 10/08/16.
//  Copyright © 2016 EpicDory. All rights reserved.
//

import UIKit

class ShareTheBillVC: UIViewController, UITextFieldDelegate {

	
	// MARK: *** @IBOutlets
	@IBOutlet weak var billValueTxtFld: UITextField!
	@IBOutlet weak var tipSelectorLbl: UILabel!
	@IBOutlet weak var tipSelectorSlider: UISlider!
	@IBOutlet weak var tipValueLbl: UILabel!
	@IBOutlet weak var totalValueLbl: UILabel!
	@IBOutlet weak var splitSelectorLbl: UILabel!
	@IBOutlet weak var splitSelectorSlider: UISlider!
	@IBOutlet weak var eachSubTotalLbl: UILabel!
	
	var currency = "Euro"
	
	// MARK: *** Variables and Properties
	var billCalc = Calculator()
	
	
	// MARK: *** View Functions
	override func viewDidLoad() {
		super.viewDidLoad()
		
		billValueTxtFld.delegate = self
		
		tipSelectorLbl.text = ("TIP \(Int(tipSelectorSlider.value*100))%")
		splitSelectorLbl.text = ("SPLIT \(Int(splitSelectorSlider.value))")
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(ShareTheBillVC.dismissKeyboard))
		view.addGestureRecognizer(tap)
		
	}

	// MARK: *** TextField
	
	@IBAction func textFieldValueUpdated(_ sender: UITextField) {
		
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		updateValues()
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		dismissKeyboard()
		return false
	}
	
	func dismissKeyboard() {
		view.endEditing(true)
	}
	
	// MARK: *** TipSlider Actions
	@IBAction func tipSliderUpdate(_ sender: AnyObject) {
		tipSelectorSlider.value = roundf(tipSelectorSlider.value*10)*0.1
		tipSelectorLbl.text = ("TIP \(Int(tipSelectorSlider.value*100))%")
		updateValues()
	}
	@IBAction func splitSliderUpdate(_ sender: AnyObject) {
		splitSelectorSlider.value = splitSelectorSlider.value.rounded()
		splitSelectorLbl.text = ("SPLIT \(Int(splitSelectorSlider.value))")
		updateValues()
	}
	
	// MARK: *** @IBActions
	@IBAction func euroPressed(_ sender: UIButton) {
		currency = "Euro"
		updateValues()
	}

	@IBAction func dollarPressed(_ sender: UIButton) {
		currency = "Dollar"
		updateValues()
	}
	
	@IBAction func otherPressed(_ sender: UIButton) {
		currency = "General"
		updateValues()
	}
	
	// MARK: *** Functions
	
	func updateValues() {
		
		var billValueToString = ""
		
		if let billValueTxt = billValueTxtFld.text {
			if !billValueTxt.characters.contains(",") && !billValueTxt.characters.contains(".") {
				billValueTxtFld.text = "\(billValueTxt),00"
				billValueToString = billValueTxt
			} else if billValueTxt.characters.contains(",") {
				billValueToString = billValueTxt.replacingOccurrences(of: ",", with: ".")
			} else {
				billValueTxtFld.text = billValueTxt.replacingOccurrences(of: ".", with: ",")
				billValueToString = billValueTxt
			}
		}
		if let billValue = Double(billValueToString) {
			billCalc.billValue = billValue
		}
		
		billCalc.tipPercent = Double(roundf(tipSelectorSlider.value*10)*0.1)
		billCalc.splitBy = Double(splitSelectorSlider.value)
		
		let tipValueTxt = String(format: "%.2f", billCalc.tipValue).replacingOccurrences(of: ".", with: ",")
		let totalValueTxt = String(format: "%.2f", billCalc.totalValue).replacingOccurrences(of: ".", with: ",")
		let eachSubTotalTxt = String(format: "%.2f", billCalc.eachSubTotalValue).replacingOccurrences(of: ".", with: ",")
		
		// Update Labels according to currency
		if currency == "Euro" {
			tipValueLbl.text = "\(tipValueTxt) €"
			totalValueLbl.text = "\(totalValueTxt) €"
			eachSubTotalLbl.text = "\(eachSubTotalTxt) €"
		} else if currency == "Dollar" {
			tipValueLbl.text = "$ \(tipValueTxt)"
			totalValueLbl.text = "$ \(totalValueTxt)"
			eachSubTotalLbl.text = "$ \(eachSubTotalTxt)"
		} else if currency == "General" {
			tipValueLbl.text = "\(tipValueTxt)"
			totalValueLbl.text = "\(totalValueTxt)"
			eachSubTotalLbl.text = "\(eachSubTotalTxt)"
		}
		
	}
	
	/*
	func updateLabelValues() {
		// Update Labels according to currency
		if currency == "Euro" {
			tipValueLbl.text = "\(tipValueTxt) €"
			totalValueLbl.text = "\(totalValueTxt) €"
			eachSubTotalLbl.text = "\(eachSubTotalTxt) €"
		} else if currency == "Dollar" {
			tipValueLbl.text = "$ \(tipValueTxt)"
			totalValueLbl.text = "$ \(totalValueTxt)"
			eachSubTotalLbl.text = "$ \(eachSubTotalTxt)"
		} else if currency == "General" {
			tipValueLbl.text = "\(tipValueTxt)"
			totalValueLbl.text = "\(totalValueTxt)"
			eachSubTotalLbl.text = "\(eachSubTotalTxt)"
		}
	}
	*/
}

