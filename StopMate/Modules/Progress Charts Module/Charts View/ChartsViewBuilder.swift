//
//  ChartsViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 20.12.2023.
//

import SwiftUI

final class ChartsViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, ProgressChartsViewModel> {
        let vm = ProgressChartsViewModel(storageService: container.firebaseStorageService)
        let vc = UIHostingController(rootView: ProgressChartsView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}

extension ProgressChartsViewModel: ViewModelBaseProtocol {} 
