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
    func chargerElement(type: String)
}

public class ServiceAPI {
    
    var delegate: ChargementDelegate?
    
    let provider = MoyaProvider<Guildwar>()
    
    
    public func getGroupe() {
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
                        self.setGroupeComplet(myData: moyaResponse.data, termine: true)
                    } else {
                        self.setGroupeComplet(myData: moyaResponse.data, termine: nil)
                    }
                } catch {
                    print("erreur de décodage")
                }
            case let .failure(error):
                print("erreur de contact API : ")
            }
        }
    }
    
    public func setGroupeComplet(myData: Data, termine: Bool?) {
        let jsonObject = try! JSON(data: myData)
        let swiftObject = Groupe(id: jsonObject[Constants.JsonKeys.id].string!, name: jsonObject[Constants.JsonKeys.name].string!, description: jsonObject[Constants.JsonKeys.description].string!, order: jsonObject[Constants.JsonKeys.order].int!, categorie: jsonObject[Constants.JsonKeys.categories].arrayObject! as! [Int])
        GroupService.shared.add(groupe: swiftObject)
        //print (GroupService.shared.getGroupe(id: 0).name)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargerElement(type: "Groupe")
            }
        }
    }
    
    public func getCategorie(ids: [Int]) {
        for id in ids {
            provider.request(.categorie(idCat: id)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        if id == ids.last {
                            self.setCategorie(jsonObject: json, termine: true)
                        } else {
                            self.setCategorie(jsonObject: json, termine: nil)
                        }
                    } catch {
                        print("erreur de décodage")
                    }
                case let .failure(error):
                    print ("erreur de contact API")
                }
            }
        }
    }
    
    public func setCategorie(jsonObject: JSON, termine: Bool?) {
        let swiftObject = Categorie(id: jsonObject[Constants.JsonKeys.id].int!, name: jsonObject[Constants.JsonKeys.name].string!, description: jsonObject[Constants.JsonKeys.description].string!, order: jsonObject[Constants.JsonKeys.order].int!, icon: jsonObject[Constants.JsonKeys.icon].url!, achievements: jsonObject[Constants.JsonKeys.achievements].arrayObject! as! [Int]) //description peut être vide
        CategorieService.shared.add(categorie: swiftObject)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargerElement(type: "Categorie")
            }
        }
    }
    
    public func getListeSucces(ids: [Int]) {
        var urlSucces: String = ""
        for id in ids {
            if id == ids.last {
                urlSucces = urlSucces+String(id)
            } else {
                urlSucces = urlSucces+String(id)+","
            }
        }
        provider.request(.listeSucces(ids: urlSucces)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let jsons = try! JSON(data:moyaResponse.data)
                    for i in 0..<jsons.count {
                        if i == jsons.count-1 {
                            self.setListeSucces(myData: jsons[i], termine: true)
                        } else {
                            self.setListeSucces(myData: jsons[i], termine: nil)
                        }
                    }
                }
            case let .failure(error):
                print("erreur de contact API")
            }
        }
    }
    
    public func setListeSucces(myData: JSON, termine: Bool?) {
        let swiftObject = Succes(id: myData[Constants.JsonKeys.id].int!, name: myData[Constants.JsonKeys.name].string!, description: myData[Constants.JsonKeys.description].string!, requirement: myData[Constants.JsonKeys.requirement].string!, locked_text: myData[Constants.JsonKeys.locked_text].string!, type: myData[Constants.JsonKeys.type].string!, flags: myData[Constants.JsonKeys.flags].arrayObject! as! [String])
        SuccesService.shared.add(succes: swiftObject)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargerElement(type: "Succes")
            }
        }
    }

}
