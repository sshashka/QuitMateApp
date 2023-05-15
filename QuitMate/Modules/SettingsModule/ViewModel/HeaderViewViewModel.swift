//
//  HeaderViewViewModek.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

class HeaderViewViewModel: ObservableObject {
    @Published var image: Data?
    @Published var name: String
    @Published var email: String
    
    init(image: Data? = nil, name: String, email: String) {
        self.image = image
        self.name = name
        self.email = email
    }
}
