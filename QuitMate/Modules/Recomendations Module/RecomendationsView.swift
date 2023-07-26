//
//  RecomendationsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.06.2023.
//

import SwiftUI

struct RecomendationsView: View {
    @StateObject var viewModel: RecomendationsViewModel
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                Text(viewModel.recomendation)
                    .fontStyle(.recomendationsText)
            }.overlay(content: {
                if viewModel.state == .loading {
                    CustomProgressView()
                }
            })
            .padding(.bottom, Spacings.spacing15)
            Button {
                viewModel.generateResponse()
            } label: {
                Text("Regenerate response")
            }.buttonStyle(StandartButtonStyle())
            
            Button {
                viewModel.didTapDone()
            } label: {
                Text("Done")
            }.buttonStyle(StandartButtonStyle())
        }.padding([.horizontal, .bottom], Spacings.spacing30)
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



