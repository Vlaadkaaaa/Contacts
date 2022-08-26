//
//  ViewController.swift
//  Contacts
//
//  Created by Владислав Лымарь on 25.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private var contacts: [ContactProtocol] = []{
        didSet{
            contacts.sort {$0.title < $1.title}
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadContacts()
    }
    
    
    //MARK: - Methods
    //Метод добавляет контакты в массив
    func loadContacts(){
        contacts.append(
            Contact(title: "Саня Техосмотр", phone: "+799912312323"))
        contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
        contacts.append(Contact(title: "Сильвестр", phone: "+7000911112"))
    }
    
    //MARK: - Action
        @IBAction func showNewContactAlert(){
        //Создание AlertController
            let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
            
            //добавляем первое и второе текстовое поле в alertController
            alertController.addTextField { textField in
                textField.placeholder = "Введите имя"
            }
            alertController.addTextField { textField in
                textField.placeholder = "Введите номер"
            }
            
            //Создаем кнопки
            //Создание кнопки добавления
            let createButton = UIAlertAction(title: "Добавить", style: .default) { _ in
                guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else {return }
                //Создаем новый контакт
                let contact = Contact(title: contactName, phone: contactPhone)
                self.contacts.append(contact)
                self.tableView.reloadData()
            }
            //Создание кнопки отмены
            let cancelButton = UIAlertAction(title: "Отмена", style: .cancel)
            
            //Добавляем кнопки в alertController
            alertController.addAction(createButton)
            alertController.addAction(cancelButton)
            
            
            //Отображаем Alert
            self.present(alertController, animated: true)
    }
}


//MARK: Extension

//DataSource Extension
extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell
        
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "MyCell"){
            print("Используем старую ячейку для строки с индексом - \(indexPath.row)")
            cell = reuseCell
        } else{
            print("Создаем новую ячейку для строки с индексом - \(indexPath.row)")
            cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        }
        
        configure(cell: &cell, for: indexPath)
        return cell
    }
    private func configure(cell: inout UITableViewCell, for indexPath: IndexPath){
        var configuration = cell.defaultContentConfiguration()
        //имя контакта
        configuration.text = contacts[indexPath.row].title
        //телефон контакта
        configuration.secondaryText = contacts[indexPath.row].phone
        cell.contentConfiguration = configuration
    }
}

//Delegate Extension
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //действие удаления
        let actionDelete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            //удаляем контакт
            self.contacts.remove(at: indexPath.row)
            //заново формируем табличное представление
            tableView.reloadData()
        }
        
        let actions = UISwipeActionsConfiguration(actions: [actionDelete])
        return actions
    }
}
