//
//  DoorsCell.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

final class DoorsCell: UITableViewCell {
    
    private var isImageHidden: Bool = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var doorTextField: UITextField!
    @IBOutlet weak var favoritImageDoors: UIImageView!
    
    // MARK: - Override
    
    override func prepareForReuse() {
        doorTextField.text = nil
    }
    
    func toggleImage() {
        isImageHidden = !isImageHidden
        favoritImageDoors.isHidden = isImageHidden
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
