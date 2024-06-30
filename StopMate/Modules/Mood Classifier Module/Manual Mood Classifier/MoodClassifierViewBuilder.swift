//
//  MoodClassifierViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 20.12.2023.
//

import SwiftUI

final class MoodClassifierViewBuilder {
    static func build(contailer: AppContainer) -> Module<UIViewController, ManualMoodClassifierModuleViewModel> {
        let vm = ManualMoodClassifierModuleViewModel(storageService: contailer.firebaseStorageService)
        let vc = UIHostingController(rootView: ManualMoodClassifierView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}

extension ManualMoodClassifierModuleViewModel: ViewModelBaseProtocol {}
