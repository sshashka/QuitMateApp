//
//  UserModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

struct User: Codable {
    var name: String
    var age: Int
    var email: String
    var id: String
    var profileImage: Data?
}
