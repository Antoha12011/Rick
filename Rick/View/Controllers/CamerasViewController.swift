//  print(Realm.Configuration.defaultConfiguration.fileURL!)
//  CamerasViewController.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import RealmSwift
import Alamofire

final class CamerasViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let realm = try! Realm()
    private let cellIdentifier = "CamerasCell"
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
        fetchData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        camTableView.reloadData()
        camTableView.refreshControl = UIRefreshControl()
        camTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        camTableView.refreshControl?.tintColor = .black
    }
    
    // MARK: - Public Methods
    
    @objc func refreshData() {
        fetchDataFromNetwork()
    }
    
    // MARK: - Actions
    
    @IBAction func doorBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let vc = storyboard.instantiateViewController(withIdentifier: "DoorsViewController")
        self.present(vc, animated: false, completion: nil);
    }
    
    // MARK: - Private Methods
    
    private func fetchDataFromNetwork() {
        guard isInternetAvailable() else {
            camTableView.refreshControl?.endRefreshing()
            return
        }
        networkService.getCameras { [weak self] values in
            self?.networkData = values
            self?.realmManager.saveDataToRealm(data: values.cameras)
            DispatchQueue.main.async {
                self?.camTableView.reloadData()
                self?.camTableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func isInternetAvailable() -> Bool {
        let networkManager = NetworkReachabilityManager()
        return networkManager?.isReachable ?? false
    }
    
    private func fetchData() {
        isInternetAviable = isInternetAvailable()
        realmData = realmManager.fetchCameras()
        if isInternetAviable == true {
            fetchDataFromNetwork()
        } else if realmData.isEmpty {
            let alert = UIAlertController(title: "Проблемы с интернетом!", message: "К сожалению, загруженных данных на вашем телефоне нет, подключитесь к интернету", preferredStyle: .actionSheet)
            let okBtn = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                self.camTableView.reloadData()
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
            return realmData?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CamerasCell else {
            return UITableViewCell()
        }
        
        if isInternetAviable ?? true, let networkData = networkData {
            let cameraNet = networkData.cameras[indexPath.row]
            cell.configureFromRealmOrNet(cameraNet)
        } else {
            let cameraDB = realmData[indexPath.row]
            cell.configureFromRealmOrNet(cameraDB)
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
        if let starImage = UIImage(named: "star")?.resized(to: CGSize(width: 40, height: 40)) {
                favoritAction.image = starImage
            }
        favoritAction.backgroundColor = .white
        let configuration = UISwipeActionsConfiguration(actions: [favoritAction])
        return configuration
    }
}
