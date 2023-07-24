//
//  CamerasCell.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import Kingfisher

class CamerasCell: UITableViewCell {

    @IBOutlet weak var camImage: UIImageView!
    @IBOutlet weak var camLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        camImage.layer.cornerRadius = 10
    }
    
    func configureKing(_ model: Camera) {
        guard let url = URL(string: model.snapshot ?? "Изображения нет") else { return }
        camImage.kf.setImage(with: url, placeholder: nil)
    }
    
    override func prepareForReuse() {
        camLabel.text = nil
        camImage.image = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
