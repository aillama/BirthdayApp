//
//  Friend.swift
//  BirthdayApp
//
//  Created by Ananya Gogula on 7/25/25.
//

import Foundation

class Friend {
    //not equals sign because it is an empty data type
    var name: String
    var birthday: Date
    
    init(name: String, birthday: Date) {
        self.name = name
        self.birthday = birthday
    }
}
