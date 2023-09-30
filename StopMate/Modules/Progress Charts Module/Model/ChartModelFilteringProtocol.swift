//
//  ChartModelFilteringProtocol.swift
//  StopMate
//
//  Created by Саша Василенко on 05.09.2023.
//

import Foundation

protocol ChartDataFilteringProtocol {
    var dateOfClassification: Date { get }
    var classification: ClassifiedMood { get }
}
