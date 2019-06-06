//
//  ServiceAPI.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation
import Moya

public class ServiceAPI {
    let provider = MoyaProvider<Guildwar>()
    
    
    public func getGroupe() {
        provider.request(.groupe) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    print (try moyaResponse.mapJSON())
                } catch {
                    
                }
            case let .failure(error):
                print("erreur de contact API : ")
            }
        }
    }
    
}
