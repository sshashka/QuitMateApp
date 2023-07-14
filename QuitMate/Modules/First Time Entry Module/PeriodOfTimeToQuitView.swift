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
//    let dateRange: ClosedRange<Date> = {
//        let calendar = Calendar.current
//        let startComponents = Date.now.toDateComponents(neededComponents: [.year, .month, .day])
//        let endComponents = DateComponents(year: 2023, month: 12, day: 31, hour: 23, minute: 59, second: 59)
//        return calendar.date(from:startComponents)!
//        ...
//        calendar.date(from:endComponents)!
//    }()
    @Binding var date: Date
    var body: some View {
        VStack {
            FirstTimeEntryHeaderView(text: headerText)
            Spacer()
            DatePicker(datePickerText, selection: $date, in: period.getPeriod(), displayedComponents: .date)
                .font(.custom(FontsEnum.poppinsBold.rawValue, size: 24))
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
