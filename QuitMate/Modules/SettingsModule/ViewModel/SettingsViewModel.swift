//
//  SettingsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.05.2023.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    private var disposeBag = Set<AnyCancellable>()
    @Published var userModel = [User]() {
        didSet {
            getViewModels()
        }
    }
    @Published var headerViewModel: [HeaderViewViewModel] = []
    func didTapLogout() {
        
    }
    
    func getUserModel() {
        FirebaseStorageService().getUserModel()
            .sink {
                print($0)
            } receiveValue: {[weak self] in
                self?.userModel = $0
            }.store(in: &disposeBag)
    }
    
    func getViewModels() {
        guard let user = userModel.first else { return }
        let model = HeaderViewViewModel(name: user.name, email: user.email, image: user.profileImage ?? nil)
        headerViewModel.append(model)
    }
    
}
