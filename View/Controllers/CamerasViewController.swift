//
//  CamerasViewController.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit

class CamerasViewController: UIViewController {
    
    private var networkService = NetworkService()
    
    @IBOutlet weak var camTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchChannels()
    }
    
    func fetchChannels() {
        guard let url = URL(string: "http://cars.cprogroup.ru/api/rubetek/cameras/") else { return }
        networkService.fetchChannels(url: url) { result in
            switch result {
            case .success(_):
                print("")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension CamerasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CamerasCell
        
//        cell.camLabel.text = cam[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
}
