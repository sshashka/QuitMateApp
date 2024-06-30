//
//  OnboardingViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 24.11.2023.
//

import SwiftUI
import UIKit

final class OnboardingViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, OnboardingViewModel> {
        let vm = OnboardingViewModel(storageService: container.firebaseStorageService)
        let vc = UIHostingController(rootView: OnboardingView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}

