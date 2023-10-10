//
//  RecomendationsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.06.2023.
//

import SwiftUI

struct RecomendationsView<ViewModel>: View where ViewModel: RecomendationsViewModelProtocol {
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Text(viewModel.recomendation)
                    .fontStyle(.recomendationsText)
            }
            .isEnabled(viewModel.doneAndRegenerateButtonsEnabled)
            .overlay(content: {
                if viewModel.state == .loading {
                    CustomProgressView()
                }
            })
            .padding(.bottom, Spacings.spacing15)
            .buttonStyle(StandartButtonStyle())
            .isEnabled(viewModel.doneAndRegenerateButtonsEnabled)
            Button {
                viewModel.didTapDone()
            } label: {
                Text(Localizables.Shared.done)
            }
            .buttonStyle(StandartButtonStyle())
            .isEnabled(viewModel.doneAndRegenerateButtonsEnabled)
        }
        .padding([.horizontal, .bottom], Spacings.spacing30)
        .onAppear {
            viewModel.start()
        }
    }
}

struct RecomendationsView_Previews: PreviewProvider {
    static var previews: some View {
        let storage = FirebaseStorageService()
        @State var vm = RecomendationsViewModel(storageService: storage, type: .moodRecomendation)
        RecomendationsView(viewModel: vm)
    }
}



