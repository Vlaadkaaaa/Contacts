//
//  ViewController.swift
//  Contacts
//
//  Created by Владислав Лымарь on 25.08.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //получаем экземпляр ячейки
        let cell = UITableViewCell(style: .default, reuseIdentifier: "contactCellIdentifier")
        //конфигурируем ячейку
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "Строка \(indexPath.row)"
        cell.contentConfiguration = configuration
        
        //возвращаем сконфигурированный экземпляр ячейки
        return cell
    }
    
    
    
}
