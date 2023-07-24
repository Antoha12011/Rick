//
//  CamerasViewController.swift
//  Rick
//
//  Created by Антон Павлов on 24.07.2023.
//

import UIKit

//  http://cars.cprogroup.ru/api/rubetek/cameras/ --> Cameras JSON

class CamerasViewController: UIViewController {
    
    private var networkService = NetworkService()
    
    var cam = [Camera]()
    
    @IBOutlet weak var camTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkService.getData()
    }
}

extension CamerasViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cam.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CamerasCell
        
        cell.camLabel.text = cam[indexPath.row].name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    
}
