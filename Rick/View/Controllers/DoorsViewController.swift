//
//  DoorsViewController.swift
//  Rick
//
//  Created by Антон Павлов on 25.07.2023.
//

import UIKit
import RealmSwift
import Alamofire

final class DoorsViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let realm = try! Realm()
    private let sectionOneIdentifier = "DoorsCell"
    private let sectionTwoIdentifier = "DoorsCellWithImage"
    private var networkData: DoorData?
    private let networkService = NetworkService()
    private let realmManager = RealmManager()
    private var realmData: Results<RoomsRealm>!
    private var section0Data: [Door]?
    private var section1Data: [Door]?
    private var isInternetAviable: Bool?
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var doorTableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navBar.shadowImage = UIImage()
        fetchData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doorTableView.reloadData()
        doorTableView.refreshControl = UIRefreshControl()
        doorTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        doorTableView.refreshControl?.tintColor = .black
    }
    
    // MARK: - Public Methods
    
    @objc func refreshData() {
        fetchDataFromNetwork()
    }
    
    private func fetchDataFromNetwork() {
        guard isInternetAvailable() else {
            doorTableView.refreshControl?.endRefreshing()
            return
        }
        networkService.getDoors{ [weak self] values in
            self!.networkData = values
            self!.section0Data = values?.data
            self!.section1Data = values?.data
            
            self?.realmManager.saveRoomsToRealm(data: values!.data)
            DispatchQueue.main.async {
                self?.doorTableView.reloadData()
                self?.doorTableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func isInternetAvailable() -> Bool {
        let networkManager = NetworkReachabilityManager()
        return networkManager?.isReachable ?? false
    }
    
    private func fetchData() {
        isInternetAviable = isInternetAvailable()
        realmData = realmManager.fetchRooms()
        if isInternetAviable == true {
            fetchDataFromNetwork()
        } else if realmData.isEmpty {
            let alert = UIAlertController(title: "Проблемы с интернетом!", message: "К сожалению, загруженных данных на вашем телефоне нет, подключитесь к интернету", preferredStyle: .actionSheet)
            let okBtn = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
            alert.addAction(okBtn)
            present(alert, animated: true, completion: nil)
        } else {
            DispatchQueue.main.async {
                self.doorTableView.reloadData()
            }
        }
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionOneIdentifier, for: indexPath) as! DoorsCell
            let door = section0Data?[indexPath.row]
            cell.doorTextField.text = door?.name
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: sectionTwoIdentifier, for: indexPath) as! DoorsWithImageCell
            if let cameraData = section1Data?[indexPath.row] as? Door {
                cell.configureFromNetwork(cameraData)
            }
            
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = true
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? CGFloat(120.0) : CGFloat(280.0)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoritAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            if let cell = tableView.cellForRow(at: indexPath) as? DoorsCell {
                cell.toggleImage()
            }
            if let cell = tableView.cellForRow(at: indexPath) as? DoorsWithImageCell {
                cell.toggleImage()
            }
            completionHandler(true)
        }
        if let starImage = UIImage(named: "star")?.resized(to: CGSize(width: 40, height: 40)) {
            favoritAction.image = starImage
        }
        favoritAction.backgroundColor = .white
        
        let renameAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            if let cell = tableView.cellForRow(at: indexPath) as? DoorsCell {
                cell.doorTextField.isEnabled = true
                cell.doorTextField.becomeFirstResponder()
            }
            if let cell = tableView.cellForRow(at: indexPath) as? DoorsWithImageCell {
                cell.domofonTextField.isEnabled = true
                cell.domofonTextField.becomeFirstResponder()
            }
            completionHandler(true)
        }
        if let editImage = UIImage(named: "edit")?.resized(to: CGSize(width: 40, height: 40)) {
            renameAction.image = editImage
        }
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
