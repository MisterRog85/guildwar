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
    var retourComplet: [GroupeComplexe] = []
    
    public func getGroupe() {
        provider.request(.groupe) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    //print (try moyaResponse.mapJSON())
                    let jsons = try JSON(data: moyaResponse.data)
                    
                    for i in 0..<jsons.count {
                        //print (jsons[i].string!)
                        self.getGroupeComplet(id: jsons[i].string!)
                    }
                
                    if let id = jsons[10].string {
                        //print (id)
                    } else {
                        //print ("erreur avec swiftyJSON")
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
                    //print (try moyaResponse.mapJSON())
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
        let jsonArray = try! JSON(data: myData)
        
        print(jsonArray[0])
        /*for (index, elem) in jsonArray {
            //let thisObject = GroupeComplexe(id: elem{"id"})
            print (elem[index]{"id"}.string)
        }*/
        
        
    }
}
