//
//  DoorsCell.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

class DoorsCell: UITableViewCell {

    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var doorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    override open var frame: CGRect {
        get {
            return super.frame
        }
        set {
            var frame =  newValue
            frame.size.height -= 20
            super.frame = frame
        }
    }
}
