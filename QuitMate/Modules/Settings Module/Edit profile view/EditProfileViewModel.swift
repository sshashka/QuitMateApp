//
//  EditProfileViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.07.2023.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    @Published private (set) var user: User? {
        didSet {
            setUserImage()
            setUserData()
        }
    }
    private var disposeBag = Set<AnyCancellable>()
    private let storageService: FirebaseStorageServiceProtocol
    @Published var userName: String = "" 
    @Published var userAge: String = ""
    @Published var userEmail: String = ""
    @Published var spendMoney: String = ""
    @Published var userImage: Data?
//     
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        downloadUser()
    }
    
    private func downloadUser() {
//        storageService.userPublisher
        storageService.getUserModel()
            .sink {
            print($0)
        } receiveValue: { [weak self] user in
            self?.user = user
        }.store(in: &disposeBag)
    }
    
    func updateImage(with image: Data) {
        userImage = image
        storageService.updateUserProfilePic(with: image)
    }
    
    private func setUserImage() {
        guard let user else { return }
        userImage = user.profileImageInData()
    }
    
    private func setUserData() {
        guard let user else { return }
        userName = user.name
        userAge = user.age
        userEmail = userEmail
        spendMoney = String(user.moneyUserSpendsOnSmoking)
    }
}
