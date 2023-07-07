//
//  VideoSelectionView.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.07.2023.
//

import SwiftUI

struct VideoSelectionView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<9) {_ in
                VideoCell()
            }
        }
    }
}

struct VideoSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        VideoSelectionView()
    }
}
