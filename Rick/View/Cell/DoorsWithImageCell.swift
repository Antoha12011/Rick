//
//  DoorsWithImageCell.swift
//  Rick
//
//  Created by Антон Павлов on 26.07.2023.
//

import UIKit

final class DoorsWithImageCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var visualImg: UIImageView!
    @IBOutlet weak var lockImg: UIImageView!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        visualImg.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        visualImg.image = nil
        visualImg.image = nil
    }
}
