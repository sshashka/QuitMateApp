//
//  ReasonsToStopNewFinishingDateViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 20.12.2023.
//

import SwiftUI

final class ReasonsToStopNewFinishingDateViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, ReasonsToStopNewFinishingDateViewModel> {
        let vm = ReasonsToStopNewFinishingDateViewModel(storageService: container.firebaseStorageService)
        let vc = UIHostingController(rootView: ReasonsToStopNewFinishingDateView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
                                                            
}

extension ReasonsToStopNewFinishingDateViewModel: ViewModelBaseProtocol {}
