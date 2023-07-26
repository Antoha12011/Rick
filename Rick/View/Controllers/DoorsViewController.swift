//
//  DoorsViewController.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

final class DoorsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var doorTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.shadowImage = UIImage()
    }
    
    // MARK: - Actions
    
    @IBAction func camBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "CamerasViewController")
        self.present(vc, animated: false, completion: nil);
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension DoorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 3 }
        else if section == 1 { return 1 }
        else { return 1 }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DoorsCell", for: indexPath) as! DoorsCell
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true
            return cell
            
        } else if indexPath.section == 1 {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "DoorsCellWithImage", for: indexPath) as! DoorsWithImageCell
            cell2.contentView.layer.cornerRadius = 10
            cell2.contentView.layer.masksToBounds = true
            return cell2
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? CGFloat(120.0) : CGFloat(280.0)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoritAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            completionHandler(true)
        }
        favoritAction.image = UIImage(named: "star")
        favoritAction.backgroundColor = .white
        
        let renameAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            if let cell = tableView.cellForRow(at: indexPath) as? DoorsCell {
                cell.doorTextField.isEnabled = true
                cell.doorTextField.becomeFirstResponder()
            }
            completionHandler(true)
        }
        renameAction.image = UIImage(named: "edit")
        renameAction.backgroundColor = .white
        
        let configuration = UISwipeActionsConfiguration(actions: [favoritAction, renameAction])
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailDomofonViewController")
        self.present(vc, animated: false, completion: nil);
    }
}
