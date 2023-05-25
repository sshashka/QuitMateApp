//
//  HeaderViewViewModek.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

class HeaderViewViewModel: ObservableObject {
    @Published var image: Data?
    @Published var name: String = ""
    @Published var email: String = ""
    
    init(user: User) {
        updateWith(user: user)
    }
    
    func updateWith(user: User) {
        self.image = user.profileImage
        self.name = user.name
        self.email = user.email
    }
}
