//
//  HeaderViewViewModek.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

class HeaderViewViewModel: ObservableObject {
    @Published var image: Data?
    var name: String
    var email: String
    
    init(name: String, email: String, image: Data?) {
        self.email = email
        self.name = name
        self.image = image
    }
}
