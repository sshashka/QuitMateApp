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
    @Published var userModel: User? {
        didSet {
            getViewModels()
        }
    }
    @Published var headerViewModel: HeaderViewViewModel
    
    func didTapLogout() {
        
    }
    
    init() {
        let user = User(name: "", age: 0, email: "", id: "")
        self.headerViewModel = HeaderViewViewModel(user: user)
        getUserModel()
    }
    
    func getUserModel() {
        FirebaseStorageService().getUserModel()
            .sink {
                print($0)
            } receiveValue: {[weak self] in
                self?.userModel = $0.last
            }.store(in: &disposeBag)
    }
    
    func getViewModels() {
        guard let user = userModel else { return }
        headerViewModel.updateWith(user: user)
    }
    
}
