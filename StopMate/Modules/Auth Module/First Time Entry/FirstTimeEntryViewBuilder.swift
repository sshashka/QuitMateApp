//
//  FirstTimeEntryViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 23.11.2023.
//

import SwiftUI
import UIKit

final class FirstTimeEntryViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, FirstTimeEntryViewModel> {
        let vm = FirstTimeEntryViewModel(storageService: container.firebaseStorageService)
        let vc = UIHostingController(rootView: FirstTimeEntryView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}
