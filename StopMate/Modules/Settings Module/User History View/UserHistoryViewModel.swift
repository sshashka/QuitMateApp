//
//  UserHistoryViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.07.2023.
//

import Foundation
import Combine

protocol UserHistoryViewModelProtocol: AnyObject, ObservableObject {
    var filteredRecords: [UserHistoryModel] { get }
    var selectedHistoryType: UserHistoryRecordsType { get }
}

enum TypesOfUserHistory: Hashable {
    case timerResets, moods
}

class UserHistoryViewModel: UserHistoryViewModelProtocol {
    private var disposeBag = Set<AnyCancellable>()
    private let storageService: FirebaseStorageServiceProtocol
    private var allRecords: [UserHistoryModel]? {
        didSet {
            filteredRecords = filterRecords()
        }
    }
    // TODO: Rename TypesOfUserHistory to TypesOfHistoryRecords
    @Published var selectedHistoryType: UserHistoryRecordsType = .moodRecords {
        didSet {
            filteredRecords = filterRecords()
        }
    }
    
    @Published var filteredRecords: [UserHistoryModel] = []
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func start() {
        getUserHistory()
    }
}

private extension UserHistoryViewModel {
    func getUserHistory() {
        storageService.getUserHistory()
            .sink {
                print($0)
            } receiveValue: {[weak self] records in
                self?.allRecords = records
            }.store(in: &disposeBag)
    }
    
    func filterRecords() -> [UserHistoryModel] {
        guard let allRecords else { return [] }
        return allRecords.filter {
            $0.typeOfHistory == selectedHistoryType
        }.sorted {
            $0.dateOfClassification > $1.dateOfClassification
        }
    }
}

