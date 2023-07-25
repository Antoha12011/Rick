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
    @IBOutlet weak var recLabel: UILabel!
    @IBOutlet weak var favoritStarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        camImage.layer.cornerRadius = 10
        
    }
    
    func configure(model: CamerasRealm) {
        camLabel.text = model.name
        guard let url = URL(string: model.snapshot ?? "") else { return }
        camImage.kf.setImage(with: url, placeholder: nil)
        
    }
    
    override func prepareForReuse() {
        camLabel.text = nil
        camImage.image = nil
        recLabel.text = nil
        favoritStarImg.image = nil
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
