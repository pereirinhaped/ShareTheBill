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
		
		tipSelectorLbl.text = ("TIP \(Int(tipSelectorSlider.value))%")
		splitSelectorLbl.text = ("SPLIT \(Int(splitSelectorSlider.value))")
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(ShareTheBillVC.dismissKeyboard))
		view.addGestureRecognizer(tap)
		
	}

	// MARK: *** TextField
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		let inverseSet = NSCharacterSet(charactersIn:"0123456789,.").inverted
		
		let components = string.components(separatedBy: inverseSet)
		
		let filtered = components.joined(separator: "")
		
		guard let text = textField.text else { return true }
		
		let countdots = text.components(separatedBy: ".").count - 1
		
		if countdots > 0 && (string == "." || string == ",") { return false }
		
		let countcommas = text.components(separatedBy: ",").count - 1
		
		if countcommas > 0 && (string == "." || string == ",") { return false }
		
		let newLength = text.characters.count + string.characters.count - range.length
		
		return string == filtered && newLength <= 10
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
		
		tipSelectorSlider.value = (tipSelectorSlider.value.rounded()/10).rounded()*10
		print(tipSelectorSlider.value)
		tipSelectorLbl.text = ("TIP \(Int(tipSelectorSlider.value))%")
		if billValueTxtFld.text != "" {
			updateValues()
		}
	}
	@IBAction func splitSliderUpdate(_ sender: AnyObject) {
		splitSelectorSlider.value = splitSelectorSlider.value.rounded()
		splitSelectorLbl.text = ("SPLIT \(Int(splitSelectorSlider.value))")
		if billValueTxtFld.text != "" {
			updateValues()
		}
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
		
		// Format
		if let billValueTxt = billValueTxtFld.text {
			if !billValueTxt.characters.contains(",") && !billValueTxt.characters.contains(".") && !(billValueTxtFld.text == "") {
				billValueTxtFld.text = "\(removeZeros(aString: billValueTxt)),00"
				billValueToString = billValueTxt
			} else if billValueTxt.characters.contains(",") && !(billValueTxtFld.text == "") {
				billValueTxtFld.text = removeZeros(aString: billValueTxt)
				billValueToString = removeZeros(aString: billValueTxt.replacingOccurrences(of: ",", with: "."))
			} else if billValueTxtFld.text == "" {
				billValueTxtFld.text = ""
				billValueToString = "0"
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
}

