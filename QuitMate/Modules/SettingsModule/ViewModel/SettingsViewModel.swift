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
    @Published var userModel: User?
    @Published var headerViewModel: HeaderViewViewModel?
    
    func didTapLogout() {
        
    }
    
    init() {
        getUserModel()
    }
    
    func getUserModel() {
        FirebaseStorageService().getUserModel()
            .sink {
                print($0)
            } receiveValue: {[weak self] in
                self?.userModel = $0.first
            }.store(in: &disposeBag)
    }
    
    func getViewModels() {
        
    }
    
}
