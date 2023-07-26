//
//  DoorsCell.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

final class DoorsCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var doorTextField: UITextField!
    
    // MARK: - Override
    
    override func prepareForReuse() {
        doorTextField.text = nil
        lockImageView.image = nil
    }
    
    override public var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame =  newValue
            frame.size.height -= 10
            super.frame = frame
        }
    }
}
