//
//  ApiKeysService.swift
//  StopMate
//
//  Created by Саша Василенко on 26.09.2023.
//

import KeychainSwift

enum ApiKeys: String {
    case aiServiceKey = "AiServiceKey"
    case youtubeServiceKey = "YoutubeServiceKey"
}

class ApiKeysService {
    let keychainHandler = KeychainSwift()
    static var shared = ApiKeysService()
    ///Returns youtube api key
    var youtubeApiKey: String {
        let data = keychainHandler.get(ApiKeys.youtubeServiceKey.rawValue)
        if let data {
            return data
        }
        return String()
    }
    ///Returns generative AI api key
    var aiKey: String {
        let data = keychainHandler.get(ApiKeys.aiServiceKey.rawValue)
        if let data {
            return data
        }
        return String()
    }
    
    func setKeys() {
        let service = FirebaseStorageService()
        service.getAiKey {[weak self] result in
            self?.keychainHandler.set(result, forKey: ApiKeys.aiServiceKey.rawValue)
        }
        
        service.getYoutubeApiKey {[weak self] result in
            self?.keychainHandler.set(result, forKey: ApiKeys.youtubeServiceKey.rawValue)
        }
    }
    
    func removeKeys() {
        // I cant`t just use clear() since it conflicts with Firebase auth credentials
        keychainHandler.delete(ApiKeys.aiServiceKey.rawValue)
        keychainHandler.delete(ApiKeys.youtubeServiceKey.rawValue)
    }
}
