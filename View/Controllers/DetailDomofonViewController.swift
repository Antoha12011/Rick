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
    @IBOutlet weak var openDoor: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        
        openDoor.layer.cornerRadius = 10
    }
    @IBAction func openDoorBtn(_ sender: Any) {
        
    }
    
    @IBAction func returnBtn(_ sender: Any) {
    }
}
