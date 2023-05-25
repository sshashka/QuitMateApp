//
//  PeriodOfTimeToQuitView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.05.2023.
//

import SwiftUI

struct PeriodOfTimeToQuitView: View {
    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = Date.now.toDateComponents(neededComponents: [.year, .month, .day])
        let endComponents = DateComponents(year: 2023, month: 12, day: 31, hour: 23, minute: 59, second: 59)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    @State var date = Date()
    var body: some View {
        VStack {
            DatePicker("Finishing date", selection: $date, in: dateRange, displayedComponents: .date)
            Spacer()
            Button {
                
            } label: {
                TextView(text: "Next step", font: .poppinsBold, size: 14)
            }.buttonStyle(StandartButtonStyle())
        }
        .padding(Spacings.spacing30)
    }
}

struct PeriodOfTimeToQuitView_Previews: PreviewProvider {
    static var previews: some View {
        PeriodOfTimeToQuitView()
    }
}
