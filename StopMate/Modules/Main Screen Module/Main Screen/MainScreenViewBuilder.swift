//
//  MainScreenViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 19.12.2023.
//

import Foundation
import SwiftUI


final class MainScreenViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, MainScreenViewModel> {
        let vm = MainScreenViewModel(storageService: container.firebaseStorageService)
        let vc = UIHostingController(rootView: MainScreenView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
        
    }
}

extension MainScreenViewModel: ViewModelBaseProtocol {}
