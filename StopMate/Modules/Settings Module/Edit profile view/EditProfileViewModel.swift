//
//  EditProfileViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.07.2023.
//

import Foundation
import Combine

class EditProfileViewModel: ObservableObject {
    var didSendEventClosure: ((EditProfileViewModel.EventTypes) -> Void)?
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
    
    func updateUserProfile() {
        guard var user = user else { return }
        user.name = userName
        user.age = userAge
        user.email = userEmail
        storageService.updateUserProfileData(user: user)
        
        didSendEventClosure?(.done)
    }
    
    private func downloadUser() {
//        storageService.userPublisher
        storageService.userDataPublisher
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
        storageService.retrieveUserProfilePic()
        storageService.userProfilePicturePublisher
            .sink { error in
            print(error)
        } receiveValue: { [weak self] data in
            self?.userImage = data
        }.store(in: &disposeBag)
    }
    
    private func setUserData() {
        guard let user else { return }
        userName = user.name
        userAge = user.age
        userEmail = user.email ?? ""
        spendMoney = String(user.moneyUserSpendsOnSmoking)
    }
}

extension EditProfileViewModel {
    enum EventTypes {
        case done
    }
}
