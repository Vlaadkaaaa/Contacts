//
//  Contact.swift
//  Contacts
//
//  Created by Владислав Лымарь on 26.08.2022.
//

import Foundation

protocol ContactStorageProtocol{
    //загрузка списка контактов
    func load() -> [ContactProtocol]
    //обновление списка контактов
    func save(contacts: [ContactProtocol])
}

protocol ContactProtocol{
    var title: String {get set}
    var phone: String  {get set}
}

struct Contact: ContactProtocol{
    var title: String
    var phone: String
    
}


class ContactStorage: ContactStorageProtocol{
    //ссылка на хранилище
    private var storage = UserDefaults.standard
    //Ключ, по которому будет происходить сохранение хранилища
    private var storageKey = "contacts"
    
    //перечисление с ключами для записи в UserDefaults
    private enum ContactKey: String{
        case title
        case phone
    }
    
    func load() -> [ContactProtocol] {
        var resulContacts: [ContactProtocol] = []
        let contactFromStorage = storage.array(forKey: storageKey) as? [[String: String]] ?? []
        for contact in contactFromStorage{
            guard let title = contact[ContactKey.title.rawValue],
                  let phone = contact[ContactKey.phone.rawValue]
            else{ continue}
            resulContacts.append(Contact(title: title, phone: phone))
        }
        return resulContacts
    }
    
    func save(contacts: [ContactProtocol]) {
        var arrayFromStorage: [[String: String]] = []
        contacts.forEach { contact in
            var newElementForStorage: Dictionary<String, String> = [:]
            newElementForStorage[ContactKey.title.rawValue] = contact.title
            newElementForStorage[ContactKey.phone.rawValue] = contact.phone
            arrayFromStorage.append(newElementForStorage)
        }
        storage.set(arrayFromStorage, forKey: storageKey)
    }
    
    
}
