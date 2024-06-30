//
//  VideosViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 20.12.2023.
//

import SwiftUI

final class VideosViewBuilder {
    static func build(container: AppContainer) -> Module<UIViewController, VideoSelectionViewModel> {
        let vm = VideoSelectionViewModel(youtubeService: container.youtubeService)
        let vc = UIHostingController(rootView: VideoSelectionView(viewModel: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}

extension VideoSelectionViewModel: ViewModelBaseProtocol {}
