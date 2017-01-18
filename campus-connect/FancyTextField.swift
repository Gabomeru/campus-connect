//
//  FancyTextField.swift
//  campus-connect
//
//  Created by Gabriel Meruvia on 1/18/17.
//  Copyright © 2017 Gabriel Meruvia. All rights reserved.
//

import UIKit

class FancyTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 5, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
         return bounds.insetBy(dx: 5, dy: 0)
    }

}
