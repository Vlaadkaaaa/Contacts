//
//  Contact.swift
//  Contacts
//
//  Created by Владислав Лымарь on 26.08.2022.
//

import Foundation

protocol ContactProtocol{
    var title: String {get set}
    var phone: String  {get set}
}

struct Contact: ContactProtocol{
    var title: String
    var phone: String
}
