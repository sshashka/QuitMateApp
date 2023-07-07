//
//  VideoCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.07.2023.
//

import SwiftUI

struct VideoCell: View {
    var body: some View {
        ZStack {
            HStack {
                Image(IconConstants.earth)
                    .resizable()
                    .frame(width: 155, height: 155)
                    .aspectRatio(1/2, contentMode: .fit)
                    
                Spacer()
                VStack(alignment: .leading) {
                    Text("CDC: Tips From Former Smokers - Tonya M.: Plugged In - Memorial - URL")
                        .fontStyle(.header)
                    Text("Description")
                        .fontStyle(.greyHeaderText)
                        .foregroundColor(.gray)
                    Text("Duration")
                        .fontStyle(.greyHeaderText)
                        .foregroundColor(.gray)
                }.aspectRatio(1/4, contentMode: .fit)
            }.padding()
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .stroke(Color(ColorConstants.buttonsColor), style: StrokeStyle(lineWidth: 3))
                .glow(color: Color(ColorConstants.buttonsColor), radius: 10)
        }.padding()
    }
}

struct VideoCell_Previews: PreviewProvider {
    static var previews: some View {
        VideoCell()
    }
}
