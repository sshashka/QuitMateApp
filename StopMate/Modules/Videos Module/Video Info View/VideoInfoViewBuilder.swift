//
//  VideoInfoViewBuilder.swift
//  StopMate
//
//  Created by Саша Василенко on 20.12.2023.
//

import SwiftUI

final class VideoInfoViewBuilder {
    static func build(container: AppContainer, id: String) -> Module<UIViewController, VideoInfoViewModel> {
        let vm = VideoInfoViewModel(youtubeService: container.youtubeService, id: id)
        let vc = UIHostingController(rootView: VideoInfoView(vm: vm))
        return Module(viewController: vc, viewModel: vm)
    }
}

extension VideoInfoViewModel: ViewModelBaseProtocol {}
