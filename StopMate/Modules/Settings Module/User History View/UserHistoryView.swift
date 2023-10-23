//
//  UserHistoryView.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.07.2023.
//

import SwiftUI

struct UserHistoryView: View {
    @StateObject var viewModel: UserHistoryViewModel
    // Needed for automatic scroll to top
    private static let topViewId = "viewIdValue"
    private let textStrings = Localizables.UserHistoryStrings.self
    var body: some View {
        VStack {
            ScrollViewReader { reader in
                ScrollView {
                    LazyVStack(spacing: Spacings.spacing10) {
                        EmptyView()
                            .id(Self.topViewId)
                        if viewModel.filteredRecords.count > 0 {
                            ForEach(viewModel.filteredRecords, id: \.self) { record in
                                GroupBox {
                                    VStack(alignment: .leading, spacing: Spacings.spacing10) {
                                        Text("UserHistory.dateOfClassification:.\(record.dateOfClassificationFormatted)")
                                        if viewModel.selectedHistoryType == .moodRecords {
                                            Text("UserHistory.yourMoodWas. \(record.selectedMoood?.localizedCase ?? Localizables.noData)")
                                        }
                                        else if viewModel.selectedHistoryType == .timerResetsRecords {
                                            Text("UserHistory.youHaveSelectedReasons.\(record.selectedReasons?.map{ $0.localizedCase}.joined(separator: ",") ?? "")")
                                        }
                                        Text("UserHistory.yourRecomendationOnThatDayWas: \(record.recomendation)")
                                    }.fontStyle(.customSemibold16)
                                }
                                .padding(.horizontal, Spacings.spacing30)
                                .padding(.top, Spacings.spacing15)
                            }
                        } else {
                            VStack(alignment: .center) {
                                Text(Localizables.noData)
                                    .fontStyle(.header)
                            }
                        }
                    }
                }
                .onChange(of: viewModel.selectedHistoryType) { _ in
                    withAnimation {
                        reader.scrollTo(Self.topViewId, anchor: .top)
                    }
                }
            }
        }
        .navigationTitle(Localizables.UserHistoryStrings.navigationTitle)
        .onAppear {
            viewModel.start()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Picker(textStrings.selectTypeOfHistory, selection: $viewModel.selectedHistoryType) {
                    Text(textStrings.moods)
                        .tag(UserHistoryRecordsType.moodRecords)
                    Text(textStrings.smokingSessions)
                        .tag(UserHistoryRecordsType.timerResetsRecords)
                }
                .pickerStyle(.menu)
                .foregroundColor(Color.buttonsPurpleColor)
            }
        }
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView(viewModel: UserHistoryViewModel(storageService: FirebaseStorageService()))
    }
}
