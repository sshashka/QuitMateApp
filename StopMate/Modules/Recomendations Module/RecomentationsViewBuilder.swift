//
//  RecomentationsViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 24.11.2023.
//

import SwiftUI
import UIKit

final class RecomentationsViewBuilder {
    static func build(container: AppContainer, typeOfRecomendation: RecomendationsViewModel.TypeOfRecomendation) -> Module<UIViewController, RecomendationsViewModel> {
        let vm = RecomendationsViewModel(storageService: container.firebaseStorageService, type: typeOfRecomendation)
        let vc = UIHostingController(rootView: RecomendationsView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}
