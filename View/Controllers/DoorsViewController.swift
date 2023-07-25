//
//  DoorsViewController.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit

class DoorsViewController: UIViewController {
    
    
    @IBOutlet weak var doorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
    }
}

extension DoorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoorsCell", for: indexPath) as? DoorsCell else {
            return UITableViewCell()
        }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    private func handleMarkAsFavorite() {
        print("Marked as favourite")
    }
    
    private func handleMarkAsEdit() {
        print("Marked as edit")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoritAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.handleMarkAsFavorite()
            completionHandler(true)
        }
        favoritAction.image = UIImage(named: "star")
        favoritAction.backgroundColor = .white
        
        let renameAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            self.handleMarkAsEdit()
            completionHandler(true)
        }
        renameAction.image = UIImage(named: "edit")
        renameAction.backgroundColor = .white
        
        let configuration = UISwipeActionsConfiguration(actions: [favoritAction, renameAction])
        return configuration
    }
    
    
}
