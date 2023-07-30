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
    @IBOutlet weak var recLabel: UILabel!
    @IBOutlet weak var favoritStarImg: UIImageView!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        camImage.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        camLabel.text = nil
        camImage.image = nil
        recLabel.text = nil
        favoritStarImg.image = nil
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
    
    func configureFromRealm(_ model: CamerasRealm) {
        camLabel.text = model.name
        guard let url = URL(string: model.snapshot) else { return }
        camImage.kf.setImage(with: url, placeholder: nil)
    }
    
    func configureFromNet(_ cameraData: DataModel, at indexPath: IndexPath) {
        let camera = cameraData.cameras[indexPath.row]
        camLabel.text = camera.name
        guard let url = URL(string: camera.snapshot) else { return }
        camImage.kf.setImage(with: url, placeholder: nil)
    }
}
