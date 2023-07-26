//
//  DetailDomofonViewController.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

final class DetailDomofonViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var detaiLabel: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var openDoor: UIButton!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        openDoor.layer.cornerRadius = 10
    }
    
    // MARK: - Actions
    
    @IBAction func returnBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "DoorsViewController")
        self.present(vc, animated: false, completion: nil);
    }
}
