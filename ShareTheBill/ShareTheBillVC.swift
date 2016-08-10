//
//  ShareTheBillVC.swift
//  ShareTheBill
//
//  Created by Pedro Pereirinha on 10/08/16.
//  Copyright © 2016 EpicDory. All rights reserved.
//

import UIKit

class ShareTheBillVC: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var billValueTxtFld: UITextField!
	
	@IBOutlet weak var tipSelectorLbl: UILabel!
	@IBOutlet weak var tipSelectorSlider: UISlider!
	@IBOutlet weak var tipValueLbl: UILabel!
	@IBOutlet weak var totalValueLbl: UILabel!
	
	@IBOutlet weak var splitSelectorLbl: UILabel!
	@IBOutlet weak var splitSelectorSlider: UISlider!
	@IBOutlet weak var eachSubTotalLbl: UILabel!
	
	var billCalc = Calculator()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		billValueTxtFld.delegate = self
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(ShareTheBillVC.dismissKeyboard))
		view.addGestureRecognizer(tap)
		
		
	}

	// TextField Delegate
	
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
		
		
		
		// Test values
		billCalc.tipPercent = 0.1
		billCalc.splitBy = 1
		
		let tipValueTxt = String(format: "%.2f", billCalc.tipValue).replacingOccurrences(of: ".", with: ",")
		let totalValueTxt = String(format: "%.2f", billCalc.totalValue).replacingOccurrences(of: ".", with: ",")
		let eachSubTotalTxt = String(format: "%.2f", billCalc.eachSubTotalValue).replacingOccurrences(of: ".", with: ",")
		
		tipValueLbl.text = "\(tipValueTxt) €"
		totalValueLbl.text = "\(totalValueTxt) €"
		eachSubTotalLbl.text = "\(eachSubTotalTxt) €"
	}
	
	
	// IB Actions
	@IBAction func euroPressed(_ sender: UIButton) {
	}

	@IBAction func dollarPressed(_ sender: UIButton) {
	}
	
	@IBAction func otherPressed(_ sender: UIButton) {
	}
	
	// Auxiliary functions
	
	
}

