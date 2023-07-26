//
//  ReasonsTopStopView+Module.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.03.2023.
//

import Foundation

extension ReasonsToStopViewController {
    static var module: ReasonsToStopViewController {
        let storageService = FirebaseStorageService()
        let view = ReasonsToStopViewController()
        let presenter = ReasonsToStopModulePresenter(storageService: storageService, view: view)
        view.presenter = presenter
        return view
    }
}
