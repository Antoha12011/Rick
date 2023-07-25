//
//  CamerasViewController.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit
import RealmSwift

//  http://cars.cprogroup.ru/api/rubetek/cameras/ --> Cameras JSON
//  http://cars.cprogroup.ru/api/rubetek/doors/ --> Doors JSON

class CamerasViewController: UIViewController {
    
    var cam: Results<CamerasRealm>!
        
    @IBOutlet weak var camTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let realm = try! Realm()
//        try! realm.write {
//            realm.deleteAll()
//        }
        
        let realm = try! Realm()
        cam = realm.objects(CamerasRealm.self)
        camTableView.reloadData()

        fetchDataFromNetwork()
    
//       print("User Realm User file location: \(realm.configuration.fileURL!.path)")
    
    }
    
    func fetchDataFromNetwork() {
          // Извлеките данные из сети и сохраните их в Realm
           let networkData: [Camera] = [
            Camera(id: 1, name: "Camera 1", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: true, rec: false, room: "FIRST"),
            Camera(id: 3, name: "Camera 2", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: true, rec: false, room: ""),
            Camera(id: 2, name: "Camera 45", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: false, rec: true, room: "FIRST"),
            Camera(id: 6, name: "Camera 89", snapshot: "https://serverspace.ru/wp-content/uploads/2019/06/backup-i-snapshot.png", favorites: true, rec: false, room: "FIRST")
           ]

           RealmManager.shared.saveDataToRealm(data: networkData)
       }
    
}

extension CamerasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cam.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CamerasCell else {
            return UITableViewCell()
        }
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
//        let cam = cam[indexPath.row]
//        cell.camLabel.text = cam.name
        cell.configure(model: cam[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
  private func handleMarkAsFavourite() {
        print("Marked as favourite")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
            -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                self.handleMarkAsFavourite()
                completionHandler(true)
            }
            deleteAction.image = UIImage(named: "star")
            deleteAction.backgroundColor = .white
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
    }
    
}
