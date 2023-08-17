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
    
    init(user: User) {
        updateWith(user: user)
        
    }
    
    func updateWith(user: User) {
        self.name = user.name
        // Decode if present
        self.email = user.email ?? ""
    }
    
    func updatePhoto(image: Data?) {
        self.image = image
    }
}
