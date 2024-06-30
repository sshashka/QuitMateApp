//
//  UserEmotionalStateViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 20.12.2023.
//

import SwiftUI

final class UserEmotionalStateViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, UserEmotionalStateViewModel> {
        let vm = UserEmotionalStateViewModel(storageService: container.firebaseStorageService)
        let vc = UIHostingController(rootView: UserEmotionalStateView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}

extension UserEmotionalStateViewModel: ViewModelBaseProtocol {}
