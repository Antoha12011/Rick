//
//  CamerasCell.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit

class CamerasCell: UITableViewCell {

    @IBOutlet weak var camImage: UIImageView!
    @IBOutlet weak var camLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
