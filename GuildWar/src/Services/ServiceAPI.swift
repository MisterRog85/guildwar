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

/**
 Classe faisant les appels vers l'API et traitant les données retournées
 */
public class ServiceAPI {
    
    var delegate: ChargementDelegate?
    
    let provider = MoyaProvider<Guildwar>()
    
    /**
     Fonction permettant de récuperer la liste de groupe
     Pour chaque élément reçu, on appel la fonction getGroupeComplet pour avoir toutes les informations concernant ce groupe
     */
    public func getGroupe() {
        provider.request(.groupe) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let jsons = try JSON(data: moyaResponse.data)
                    for i in 0..<jsons.count {
                        self.getGroupeComplet(id: jsons[i].string!, termine: (i == jsons.count - 1))
                    }
                } catch {
                    print("erreur de décodage")
                }
            case .failure(_):
                print("erreur de contact API : ")
            }
        }
    }
    
    /**
     Fonction récupérant les détails pour chaque groupe
     - parameter id: l'id du groupe souhaité de type String
     - parameter termine: booléen passant à true quand on traite le dernier groupe de l'API
     */
    public func getGroupeComplet(id: String, termine: Bool){
        provider.request(.groupeComplet(idGroupe: id)) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    self.setGroupeComplet(myData: moyaResponse.data, termine: termine)
                }
            case .failure(_):
                print("erreur de contact API : ")
            }
        }
    }
    
    /**
     Fonction permettant le remplissage du tableau pour les groupes
     - parameter myData: les données renvoyées par l'API au format data
     - parameter termine: booléen qui passe à true quand on ajoute le dernier groupe de l'API
     */
    public func setGroupeComplet(myData: Data, termine: Bool) {
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
    
    /**
     Fonction récupérant les catégories liées à un certain groupe
     - parameter ids: un tableau contenant les ids des catégories voulues, de type Int
     */
    public func getCategorie(ids: [Int]) {
        for id in ids {
            provider.request(.categorie(idCat: id)) { result in
                switch result {
                case let .success(moyaResponse):
                    do {
                        let json = try JSON(data: moyaResponse.data)
                        self.setCategorie(jsonObject: json, termine: (id == ids.last))
                    } catch {
                        print("erreur de décodage")
                    }
                case .failure(_):
                    print ("erreur de contact API")
                }
            }
        }
    }
    
    /**
     Fonction permettant le remplissage du tableau des catégories à partir des informations récupérées dans getCategorie
     - parameter jsonObject: l'objet JSON contenant une catégorie
     - parameter termine: booléen indiquant si on traite la dernière catégorie pour un groupe
     */
    public func setCategorie(jsonObject: JSON, termine: Bool) {
        let swiftObject = Categorie(id: jsonObject[Constants.JsonKeys.id].int!, name: jsonObject[Constants.JsonKeys.name].string!, description: jsonObject[Constants.JsonKeys.description].string, order: jsonObject[Constants.JsonKeys.order].int!, icon: jsonObject[Constants.JsonKeys.icon].url!, achievements: jsonObject[Constants.JsonKeys.achievements].arrayObject! as! [Int]) //description peut être vide
        CategorieService.shared.add(categorie: swiftObject)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargerElement(type: "Categorie")
            }
        }
    }
    
    /**
     Fonction récupérant les succès liés à une catégorie particulière
     - parameter ids: un tableau contenant les ids des succès voulus, de type Int
     */
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
                        self.setListeSucces(myData: jsons[i], termine: (i == jsons.count-1))
                    }
                }
            case .failure(_):
                print("erreur de contact API")
            }
        }
    }
    
    /**
     Fonction permettant de remplir le tableau de succès
     - parameter myData: les données récupérées depuis l'API au format JSON
     - parameter termine: booléen indiquant si on traite le dernier succès pour une catégorie
     */
    public func setListeSucces(myData: JSON, termine: Bool) {
        let swiftObject = Succes(id: myData[Constants.JsonKeys.id].int!, name: myData[Constants.JsonKeys.name].string!, description: myData[Constants.JsonKeys.description].string, requirement: myData[Constants.JsonKeys.requirement].string, locked_text: myData[Constants.JsonKeys.locked_text].string, type: myData[Constants.JsonKeys.type].string, flags: myData[Constants.JsonKeys.flags].arrayObject! as! [String])
        SuccesService.shared.add(succes: swiftObject)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargerElement(type: "Succes")
            }
        }
    }

}
