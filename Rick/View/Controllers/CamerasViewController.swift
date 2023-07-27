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
    
    let networkService = NetworkService()
    
    private var realmData: Results<CamerasRealm>!
    private var networkData: [Camera] = []
    private var isInternetAviable = false
    
    // MARK: - Outlets
    
    @IBOutlet weak var camTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.shadowImage = UIImage()
        
        networkService.getData { [weak self] values in
            DispatchQueue.main.async {
                guard let self else { return }
                self.networkData = values
                self.camTableView.reloadData()
            }
        }
        
//        RealmManager.shared.fetchDataFromNetwork()

//        let realm = try! Realm()
//        realmData = realm.objects(CamerasRealm.self)
//        camTableView.reloadData()
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
        if isInternetAviable == true {
            return realmData.count
        } else {
            return networkData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamerasCell", for: indexPath) as? CamerasCell else {
            return UITableViewCell()
        }
        if isInternetAviable == true {
            cell.configureFromRealm(realmData[indexPath.row])
        } else {
            cell.configureFromNet(networkData[indexPath.row])
        }
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoritAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            if let cell = tableView.cellForRow(at: indexPath) as? CamerasCell {
                cell.toggleImage()
            }
            completionHandler(true)
        }
        favoritAction.image = UIImage(named: "star")
        favoritAction.backgroundColor = .white
        let configuration = UISwipeActionsConfiguration(actions: [favoritAction])
        return configuration
    }
}
