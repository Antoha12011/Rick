//
//  DetailDomofonViewController.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

class DetailDomofonViewController: UIViewController {

    @IBOutlet weak var detaiLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var openDoorLabel: UILabel!
    @IBOutlet weak var imageWithKey: UIImageView!
    @IBOutlet weak var detailBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        detailBackgroundView.layer.cornerRadius = 10
    }
}
