//
//  ShareTheBillVC.swift
//  ShareTheBill
//
//  Created by Pedro Pereirinha on 10/08/16.
//  Copyright © 2016 EpicDory. All rights reserved.
//

import UIKit

class ShareTheBillVC: UIViewController {

	@IBOutlet weak var billValueTxtFld: UITextField!
	
	@IBOutlet weak var tipSelectorLbl: UILabel!
	@IBOutlet weak var tipSelectorSlider: UISlider!
	@IBOutlet weak var tipValueLbl: UILabel!
	@IBOutlet weak var totalValueLbl: UILabel!
	
	@IBOutlet weak var splitSelectorLbl: UILabel!
	@IBOutlet weak var splitSelectorSlider: UISlider!
	@IBOutlet weak var eachSubTotalLbl: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	// IB Actions
	@IBAction func euroPressed(_ sender: UIButton) {
	}

	@IBAction func dollarPressed(_ sender: UIButton) {
	}
	
	@IBAction func otherPressed(_ sender: UIButton) {
	}
	
	
}

