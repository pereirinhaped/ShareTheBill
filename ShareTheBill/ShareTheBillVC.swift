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
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		// Create an `NSCharacterSet` set which includes everything *but* the digits
		let inverseSet = NSCharacterSet(charactersIn:"0123456789,.").inverted
		
		// At every character in this "inverseSet" contained in the string,
		// split the string up into components which exclude the characters
		// in this inverse set
		let components = string.components(separatedBy: inverseSet)
		
		// Rejoin these components
		let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
		
		// If the original string is equal to the filtered string, i.e. if no
		// inverse characters were present to be eliminated, the input is valid
		// and the statement returns true; else it returns false
		return string == filtered
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
		
		// Left Zero cleaner
		func removeZeros(aString: String) -> String {
			if aString.characters.first != "0" {
				return aString
			}
			return removeZeros(aString: aString.substring(from: aString.index(aString.startIndex, offsetBy: 1)))
		}
		
		if let billValueTxt = billValueTxtFld.text {
			if !billValueTxt.characters.contains(",") && !billValueTxt.characters.contains(".") {
				billValueTxtFld.text = "\(removeZeros(aString: billValueTxt)),00"
				billValueToString = billValueTxt
			} else if billValueTxt.characters.contains(",") {
				billValueTxtFld.text = removeZeros(aString: billValueTxt)
				billValueToString = removeZeros(aString: billValueTxt.replacingOccurrences(of: ",", with: "."))
			} else {
				billValueTxtFld.text = removeZeros(aString: billValueTxt.replacingOccurrences(of: ".", with: ","))
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

