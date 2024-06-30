//
//  AppContainer.swift
//  StopMate
//
//  Created by Саша Василенко on 21.11.2023.
//

import Foundation

protocol AppContainer: AnyObject {
    var firebaseStorageService: FirebaseStorageServiceProtocol { get }
    var firebaseAuthService: AuthentificationServiceProtocol { get }
    var firebaseAuthStateHandler: FirebaseAuthStateHandlerProtocol { get }
    var youtubeService: YoutubeApiServiceProtocol { get }
}

class AppContainerImpl: AppContainer {
    var firebaseStorageService: FirebaseStorageServiceProtocol
    
    var firebaseAuthService: AuthentificationServiceProtocol
    
    var firebaseAuthStateHandler: FirebaseAuthStateHandlerProtocol
    
    var youtubeService: YoutubeApiServiceProtocol
    
    init() {
        let firebaseStorageService = FirebaseStorageService()
        let firebaseAuthService = FirebaseAuthentificationService()
        let firebaseAuthStateHandler = FirebaseAuthStateHandler()
        let youtubeService = YoutubeApiService()
        
        self.firebaseStorageService = firebaseStorageService
        self.firebaseAuthService = firebaseAuthService
        self.firebaseAuthStateHandler = firebaseAuthStateHandler
        self.youtubeService = youtubeService
    }
}
