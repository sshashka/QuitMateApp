//
//  MoodClassifierViewController+Module.swift
//  QuitMate
//
//  Created by Саша Василенко on 21.04.2023.
//

extension MoodClassifierViewController {
    static var module: MoodClassifierViewController {
        let service = UserMoodClassifierService()
        let view = MoodClassifierViewController()
        let storage = FirebaseStorageService()
        let presenter = AutomaticMoodClassifierModulePresenter(view: view, classifierService: service, storageService: storage)
        view.presenter = presenter
        return view
    }
}
