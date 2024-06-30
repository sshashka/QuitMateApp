//
//  Module.swift
//  StopMate
//
//  Created by Саша Василенко on 21.11.2023.
//

import UIKit

struct Module<V: UIViewController, VM: ViewModelBaseProtocol> {
    let viewController: V
    let viewModel: VM
}
