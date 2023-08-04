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
    var body: some View {
        VStack {
            Picker("Select a type of history:", selection: $viewModel.selectedHistoryType) {
                Text("Moods")
                    .tag(UserHistoryRecordsType.moodRecords)
                Text("Timer resets")
                    .tag(UserHistoryRecordsType.timerResetsRecords)
            }.pickerStyle(.segmented)
                .padding(.horizontal, Spacings.spacing30)
                .padding(.vertical, Spacings.spacing15)
            ScrollViewReader { reader in
                ScrollView {
                    LazyVStack(spacing: Spacings.spacing10) {
                        EmptyView()
                            .id(Self.topViewId)
                        if viewModel.filteredRecords.count > 0 {
                            ForEach(viewModel.filteredRecords, id: \.self) { record in
                                GroupBox {
                                    VStack(alignment: .leading, spacing: Spacings.spacing10) {
                                        Text("Date of classification: \(record.dateOfClassification)")
                                        if viewModel.selectedHistoryType == .moodRecords {
                                            Text("You mood was: \(record.selectedMoood?.rawValue ?? "No data")")
                                        }
                                        else if viewModel.selectedHistoryType == .timerResetsRecords {
                                            Text("You have selected these reasons: \(record.selectedReasons?.joined(separator: ", ") ?? "")")
                                        }
                                        Text("Your recomendation on that day was: \(record.recomendation)")
                                    }.fontStyle(.poppinsSemibold16)
                                }
//                                .frame(maxWidth: .infinity)
                                .padding(.horizontal, Spacings.spacing30)
                            }
                        } else {
                            VStack(alignment: .center) {
                                Text("No records, yet")
                                    .fontStyle(.header)
                            }
                        }
                    }
                }.onChange(of: viewModel.selectedHistoryType) { _ in
                    withAnimation {
                        reader.scrollTo(Self.topViewId, anchor: .top)
                    }
                }
            }
        }.navigationTitle("Your history")
            .onAppear {
                viewModel.start()
            }
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView(viewModel: UserHistoryViewModel(storageService: FirebaseStorageService()))
    }
}
