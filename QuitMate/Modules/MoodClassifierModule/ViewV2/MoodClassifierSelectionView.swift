//
//  MoodClassifierSelectionView.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.05.2023.
//

import SwiftUI

class MoodClassifierSelectionViewModel: ObservableObject {
    var didSendEventClosure: ((MoodClassifierSelectionViewModel.EventType) -> Void)?
    
    func didChooseClassifierType(selectedMethod: EventType) {
        self.didSendEventClosure?(selectedMethod)
    }
    
    enum EventType {
        case automatic
        case manual
    }
}

struct MoodClassifierSelectionView: View {
    @StateObject var viewModel: MoodClassifierSelectionViewModel
    var body: some View {
        VStack {
            Group {
                Button {
                    viewModel.didChooseClassifierType(selectedMethod: .automatic)
                } label: {
                    TextView(text: "Automatic", font: .poppinsSemiBold, size: 14)
                }
                Button {
                    viewModel.didChooseClassifierType(selectedMethod: .manual)
                } label: {
                    TextView(text: "Manual", font: .poppinsSemiBold, size: 14)
                }
            }.buttonStyle(StandartButtonStyle())
        }
    }
}

//struct MoodClassifierSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoodClassifierSelectionView()
//    }
//}
