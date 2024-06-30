//
//  RegistrationViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 23.11.2023.
//

import SwiftUI
import UIKit

final class RegistrationViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, RegistrationViewModel> {
        let vm = RegistrationViewModel(authentificationService: container.firebaseAuthService)
        let vc = UIHostingController(rootView: RegistrationView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}
