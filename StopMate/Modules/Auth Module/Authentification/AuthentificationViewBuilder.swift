//
//  AuthentificationViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 21.11.2023.
//

import UIKit
import SwiftUI

final class AuthentificationViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, AuthentificationViewModel> {
        let viewModel = AuthentificationViewModel(authentificationService: container.firebaseAuthService)
        let viewController = UIHostingController(rootView: AuthentificationView(viewModel: viewModel))
        return Module(viewController: viewController, viewModel: viewModel)
    }
}
