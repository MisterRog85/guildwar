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

protocol ChargementDelegate {
    func afficherElements()
}

public class ServiceAPI {
    
    var delegate: ChargementDelegate?
    
    let provider = MoyaProvider<Guildwar>()
    
    var termineComplet: Bool = false
    
    public func getGroupe() {
        let provider = MoyaProvider<Guildwar>()
        provider.request(.groupe) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let jsons = try JSON(data: moyaResponse.data)
                    for i in 0..<jsons.count {
                        if i == jsons.count - 1 {
                            self.getGroupeComplet(id: jsons[i].string!, termine: true)
                        } else {
                            self.getGroupeComplet(id: jsons[i].string!, termine: nil)
                        }
                    }
                } catch {
                    print("erreur de décodage")
                }
            case let .failure(error):
                print("erreur de contact API : ")
            }
        }
    }
    
    public func getGroupeComplet(id: String, termine: Bool?){
        provider.request(.groupeComplet(idGroupe: id)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    if termine == true {
                        self.termineComplet = true
                        self.setGroupeComplet(myData: moyaResponse.data)
                    } else {
                        self.setGroupeComplet(myData: moyaResponse.data)
                    }
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
        let swiftObject = Groupe(id: jsonObject["id"].string!, name: jsonObject["name"].string!, description: jsonObject["description"].string!, order: jsonObject["order"].int!, categorie: jsonObject["categories"].arrayObject! as! [Int])
        GroupService.shared.add(groupe: swiftObject)
        //print (GroupService.shared.getGroupe(id: 0).name)
        if self.termineComplet == true {
            if let delegateObject = delegate {
                delegateObject.afficherElements()
            }
        }
    }

}
