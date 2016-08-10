//
//  Calculator.swift
//  ShareTheBill
//
//  Created by Pedro Pereirinha on 10/08/16.
//  Copyright © 2016 EpicDory. All rights reserved.
//

import Foundation

public class Calculator {
	
	private var _billValue = 0.0
	private var _tipPercent = 0.0
	private var _splitBy = 0.0
	private var _eachSubTotalValue = 0.0
	
	public var billValue: Double {
		get {
			return _billValue
		}
		set {
			if newValue > 0.0 {
				_billValue = newValue
			} else {
				_billValue = 0.0
			}
		}
	}
	
	public var tipPercent: Double {
		get {
			return _tipPercent
		}
		set {
			if newValue >= 0.0 && newValue <= 0.5 {
				_tipPercent = newValue
			}
		}
	}
	
	public var tipValue: Double {
			return _billValue * _tipPercent
	}
	
	public var totalValue: Double {
		return _billValue * (1 + _tipPercent)
	}
	
	public var splitBy: Double {
		get {
			return _splitBy
		}
		set {
			if newValue >= 0 && newValue <= 30 {
				_splitBy = Double(newValue)
			}
		}
	}
	
	public var eachSubTotalValue: Double {
		return totalValue / _splitBy
	}
	
}
