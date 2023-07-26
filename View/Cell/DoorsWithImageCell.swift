//
//  DoorsWithImageCell.swift
//  Rick
//
//  Created by Антон Павлов on 26.07.2023.
//

import UIKit

class DoorsWithImageCell: UITableViewCell {

    @IBOutlet weak var visualImg: UIImageView!
    @IBOutlet weak var lockImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        visualImg.image = nil
        visualImg.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
