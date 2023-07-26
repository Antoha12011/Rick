//
//  CamerasViewController.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import RealmSwift

final class CamerasViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var cam: Results<CamerasRealm>!
    let realmManager = RealmManager()
    
    // MARK: - Outlets
    
    @IBOutlet weak var camTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.shadowImage = UIImage()
        realmManager.fetchDataFromNetwork()

        let realm = try! Realm()
        cam = realm.objects(CamerasRealm.self)
        camTableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func doorBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "DoorsViewController")
        self.present(vc, animated: false, completion: nil);
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CamerasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamerasCell", for: indexPath) as? CamerasCell else {
            return UITableViewCell()
        }
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        cell.configure(model: cam[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            if let cell = tableView.cellForRow(at: indexPath) as? CamerasCell {
                cell.toggleImage()
            }
            completionHandler(true)
        }
        deleteAction.image = UIImage(named: "star")
        deleteAction.backgroundColor = .white
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
