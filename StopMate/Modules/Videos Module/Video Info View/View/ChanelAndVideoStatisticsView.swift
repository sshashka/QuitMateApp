//
//  ChanelAndVideoStatisticsView.swift
//  StopMate
//
//  Created by Саша Василенко on 17.08.2023.
//

import SwiftUI

struct ChanelAndVideoStatisticsView: View {
    let chanelTitle: String
    let viewCount: String
    let likeCount: String
    var body: some View {
        HStack {
            Text(chanelTitle)
            Spacer()
            ZStack {
                HStack {
                    Image(systemName: SystemIconConstants.playFill)
                    Text(viewCount)
                    
                    Image(systemName: SystemIconConstants.handThumbs)
                    Text(likeCount)
                }
                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                    .stroke(lineWidth: 1)
            }
        }.fontStyle(.textViewText)
    }
}

struct ChanelAndVideoStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        ChanelAndVideoStatisticsView(chanelTitle: "Video", viewCount: "335", likeCount: "42")
    }
}
