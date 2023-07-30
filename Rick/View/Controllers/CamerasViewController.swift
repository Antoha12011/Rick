//  print(Realm.Configuration.defaultConfiguration.fileURL!)
//  CamerasViewController.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import RealmSwift

final class CamerasViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let realm = try! Realm()
    private let networkService = NetworkService()
    private let realmManager = RealmManager()
    private var realmData: Results<CamerasRealm>!
    private var networkData: DataModel?
    private var isInternetAviable: Bool?
   
    
    // MARK: - Outlets
    
    @IBOutlet weak var camTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.shadowImage = UIImage()
        
        realmData = realmManager.fetchCameras()
        if realmData?.isEmpty ?? true {
            fetchDataFromNetwork()
        } else {
            camTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        camTableView.reloadData()
        camTableView.refreshControl = UIRefreshControl()
        camTableView.refreshControl?.addTarget(self, action: #selector(pulldown), for: .valueChanged)
        camTableView.refreshControl?.tintColor = .black
    }
    
    // MARK: - Public Methods
    
    @objc func pulldown() {
        camTableView.reloadData()
        DispatchQueue.main.async {
            self.camTableView.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func doorBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "DoorsViewController")
        self.present(vc, animated: false, completion: nil);
    }
    
    // MARK: - Private Methods
    
    private func fetchDataFromNetwork() {
        networkService.getData { [weak self] values in
            self?.networkData = values
            self?.realmManager.saveDataToRealm(data: values.cameras)
            DispatchQueue.main.async {
                self?.camTableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CamerasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isInternetAviable == true {
            return networkData?.cameras.count ?? 0
        } else {
            return realmData.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamerasCell", for: indexPath) as? CamerasCell else {
            return UITableViewCell()
        }
        if isInternetAviable ?? true, let networkData = networkData {
            cell.configureFromNet(networkData, at: indexPath)
        } else {
            cell.configureFromRealm(realmData[indexPath.row])
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
