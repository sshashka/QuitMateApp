//
//  HeaderViewViewModek.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

final class HeaderViewViewModel: ObservableObject {
    @Published var image: Data?
    @Published var name: String = ""
    @Published var email: String = ""
    
    init(user: User, userPic: Data?) {
        updateWith(user: user, userPic: userPic)
    }
    
    func updateWith(user: User, userPic: Data?) {
        self.image = userPic
        self.name = user.name
        // Decode if present
        self.email = user.email ?? ""
    }
    
    func updatePhoto(image: Data?) {
        self.image = image
    }
}
