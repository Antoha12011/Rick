//
//  CamerasCell.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import Kingfisher

final class CamerasCell: UITableViewCell {
    
    @IBOutlet weak var camImage: UIImageView!
    @IBOutlet weak var camLabel: UILabel!
    @IBOutlet weak var recLabel: UILabel!
    @IBOutlet weak var favoritStarImg: UIImageView!
    
    var isImageHidden: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        camImage.clipsToBounds = true
    }
    
    func toggleImage() {
        isImageHidden = !isImageHidden
        favoritStarImg.isHidden = isImageHidden
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
