//
//  InputTextField.swift
//  contact
//
//  Created by Siti Norain Ishak on 29/05/2024.
//

import UIKit

class InputTextField: UITextField {
    var isValid: Bool = false {
        didSet {
            configureView()
        }
    }
    
    var hasResigned: Bool = false {
        didSet {
            configureView()
        }
    }
  
    override func resignFirstResponder() -> Bool {
        hasResigned = true
        return super.resignFirstResponder()
    }
  
    private func configureView() {
        textColor = isValid ? R.color.darkFont()! : R.color.themeRed()!
  }
}
