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
    @ObservedObject var viewModel: MoodClassifierSelectionViewModel
    var body: some View {
        VStack {
            Group {
                TextView(text: "Please specify your mood", font: .poppinsBold, size: 24)
                TextView(text: "I want to do this...", font: .poppinsMedium, size: 18)
            }.multilineTextAlignment(.leading)
            Group {
                Button {
                    viewModel.didChooseClassifierType(selectedMethod: .automatic)
                } label: {
                    TextView(text: "Automaticly", font: .poppinsSemiBold, size: 14)
                }
                Button {
                    viewModel.didChooseClassifierType(selectedMethod: .manual)
                } label: {
                    TextView(text: "By myself", font: .poppinsSemiBold, size: 14)
                }
            }.buttonStyle(StandartButtonStyle())
        }.padding(Spacings.spacing25)
    }
}

struct MoodClassifierSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var vm = MoodClassifierSelectionViewModel()
        MoodClassifierSelectionView(viewModel: vm)
    }
}
