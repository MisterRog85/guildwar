//
//  ServiceAPI.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

public class ServiceAPI {
    let provider = MoyaProvider<Guildwar>()
    
    public func getGroupe() {
        provider.request(.groupe) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let jsons = try JSON(data: moyaResponse.data)
                    for i in 0..<jsons.count {
                        self.getGroupeComplet(id: jsons[i].string!)
                    }
                } catch {
                    print("erreur de décodage")
                }
            case let .failure(error):
                print("erreur de contact API : ")
            }
        }
    }
    
    public func getGroupeComplet(id: String){
        provider.request(.groupeComplet(idGroupe: id)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    self.setGroupeComplet(myData: moyaResponse.data)
                } catch {
                    print("erreur de décodage")
                }
            case let .failure(error):
                print("erreur de contact API : ")
            }
        }
    }
    
    public func setGroupeComplet(myData: Data) {
        let jsonObject = try! JSON(data: myData)
        //print (jsonObject["name"].string!)
        var swiftObject = GroupeComplexe.init(id: jsonObject["id"].string!, name: jsonObject["name"].string!, description: jsonObject["description"].string!, order: jsonObject["order"].int!, categorie: jsonObject["categories"].arrayObject! as! [Int])
        print (swiftObject.name)
    }
}
