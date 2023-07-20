//
//  EditProfileViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.07.2023.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    @Published private (set) var user: User?
    private var disposeBag = Set<AnyCancellable>()
    private let storageService: FirebaseStorageServiceProtocol
    
//     
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
    }
    
    private func downloadUser() {
        storageService.getUserModel().sink {
            print($0)
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &disposeBag)
    }
}
