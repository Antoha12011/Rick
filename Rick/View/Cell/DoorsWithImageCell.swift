//
//  DoorsWithImageCell.swift
//  Rick
//
//  Created by Антон Павлов on 26.07.2023.
//

import UIKit
import Kingfisher

final class DoorsWithImageCell: UITableViewCell {

    private var isImageHidden: Bool = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var visualImg: UIImageView!
    @IBOutlet weak var lockImg: UIImageView!
    @IBOutlet weak var favBat: UIImageView!
    @IBOutlet weak var domofonTextField: UITextField!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        visualImg.clipsToBounds = true
    }
    
    func toggleImage() {
        isImageHidden = !isImageHidden
        favBat.isHidden = isImageHidden
    }
    
    override func prepareForReuse() {
        visualImg.image = nil
    }
    
    func configureFromNetwork(_ cameraData: Door) {
        domofonTextField.text = cameraData.name
        favBat.isHidden = !cameraData.favorites
        guard let url = URL(string: cameraData.snapshot ?? "") else { return }
        visualImg.kf.setImage(with: url, placeholder: nil)
    }
}
