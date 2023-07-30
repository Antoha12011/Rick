//
//  CamerasCell.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import Kingfisher

final class CamerasCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private var isImageHidden: Bool = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var camImage: UIImageView!
    @IBOutlet weak var camLabel: UILabel!
    @IBOutlet weak var favoritStarImg: UIImageView!
    @IBOutlet weak var recImage: UIImageView!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        camImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        camLabel.text = nil
        camImage.image = nil
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
    
    // MARK: - Public Methods
    
    func toggleImage() {
        isImageHidden = !isImageHidden
        favoritStarImg.isHidden = isImageHidden
    }
    
    func configureFromRealmOrNet(_ cameraData: Any) {
        if let model = cameraData as? CamerasRealm {
            camLabel.text = model.name
            favoritStarImg.isHidden = !model.favorites
            recImage.isHidden = !model.rec
            guard let url = URL(string: model.snapshot) else { return }
            camImage.kf.setImage(with: url, placeholder: nil)
        } else if let camera = cameraData as? Camera {
            camLabel.text = camera.name
            favoritStarImg.isHidden = !camera.favorites
            recImage.isHidden = !camera.rec
            guard let url = URL(string: camera.snapshot) else { return }
            camImage.kf.setImage(with: url, placeholder: nil)
        }
    }
}
