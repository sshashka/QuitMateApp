//
//  PeriodOfTimeToQuitView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.05.2023.
//

import SwiftUI

struct PeriodOfTimeToQuitView: View {
    enum DatePeriodType {
        case startingDate
        case finishingDate
        
        func getPeriod() -> ClosedRange<Date> {
            let now = Calendar.current.date(from: Date.now.toDateComponents(neededComponents: [.year, .month, .day]))
//            let nowPlusWeek = 
            switch self {
            case .startingDate:
                return .distantPast ... now!
            case .finishingDate:
                return now! ... .distantFuture
            }
        }
    }
    // Fix naming
    let period: DatePeriodType
    let headerText: String
    let datePickerText: String
    @Binding var date: Date
    var body: some View {
        VStack {
            FirstTimeEntryHeaderView(text: headerText)
            Spacer()
            VStack(alignment: .leading) {
                Text(datePickerText)
                    .font(.custom(FontsEnum.bold.rawValue, size: 24))
                DatePicker(datePickerText, selection: $date, in: period.getPeriod(), displayedComponents: .date)
                    .datePickerStyle(.graphical)
            }
            Spacer()
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct PeriodOfTimeToQuitView_Previews: PreviewProvider {
    static var previews: some View {
        @State var date: Date = Date()
        PeriodOfTimeToQuitView(period: .startingDate, headerText: "When did u start your quitting process?", datePickerText: "Starting date:", date: $date)
    }
}
