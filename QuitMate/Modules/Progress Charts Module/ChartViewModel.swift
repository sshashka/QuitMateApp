//
//  ChartViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.06.2023.
//

import Combine

class ChartViewModel: ObservableObject {
    @Published var data: [ChartModel]
    
    init(data: [ChartModel]) {
        self.data = data
    }
}
