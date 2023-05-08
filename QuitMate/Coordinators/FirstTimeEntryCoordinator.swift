//
//  FirstTimeEntryCoordinator.swift
//  QuitMate
//
//  Created by Саша Василенко on 27.04.2023.
//

import UIKit

protocol FirstTimeEntryCoordinatorProtocol: Coordinator {
    func showFirstTimeEntryCoordinator()
}

class FirstTimeEntryCoordinator: FirstTimeEntryCoordinatorProtocol {
    func showFirstTimeEntryCoordinator() {
        //catch did finish event
        
    }
    
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .firstTimeEntry }
    
    func start() {
        showFirstTimeEntryCoordinator()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
