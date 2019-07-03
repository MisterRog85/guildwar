//
//  ServiceAPI.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation
import Moya

protocol ChargementDelegate {
    func chargementTermine(type: String)
}

/**
 Classe faisant les appels vers l'API et traitant les données retournées
 */
public class ServiceAPI {
    
    var delegate: ChargementDelegate?
    
    let provider = MoyaProvider<Guildwar>()
    
    let decoder = JSONDecoder()
    
    /**
     Fonction permettant de récuperer la liste de groupe
     Pour chaque élément reçu, on appel la fonction getGroupeComplet pour avoir toutes les informations concernant ce groupe
     */
    public func getGroupe() {
        provider.request(.groupe) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let str = String(decoding: moyaResponse.data, as: UTF8.self)
                    let array = str.components(separatedBy: ",")
                    for i in 0..<array.count {
                        var id = array[i].replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                        id = id.replacingOccurrences(of: "\n", with: "", options: NSString.CompareOptions.literal, range: nil)
                        id = id.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)
                        id = id.replacingOccurrences(of: "[", with: "", options: NSString.CompareOptions.literal, range: nil)
                        id = id.replacingOccurrences(of: "]", with: "", options: NSString.CompareOptions.literal, range: nil)
                        self.getGroupeComplet(id: id, termine: (i == array.count - 1))
                    }
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
        let groupe = try! self.decoder.decode(Groupe.self, from: myData)
        GroupService.shared.add(groupe: groupe)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargementTermine(type: "Groupe")
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
                        self.setCategorie(myData: moyaResponse.data, termine: (id == ids.last))
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
    public func setCategorie(myData: Data, termine: Bool) {
        let categorie = try! self.decoder.decode(Categorie.self, from: myData)
        CategorieService.shared.add(categorie: categorie)
        if termine == true {
            if let delegateObject = delegate {
                delegateObject.chargementTermine(type: "Categorie")
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
                    self.setListeSucces(myData: moyaResponse.data)
                }
            case .failure(_):
                print("erreur de contact API")
            }
        }
    }
    
    /**
     Fonction permettant de remplir le tableau de succès
     - parameter myData: les données récupérées depuis l'API au format JSON
     */
    public func setListeSucces(myData: Data) {
        let succes = try! self.decoder.decode([Succes].self, from: myData)
        SuccesService.shared.addAll(liste: succes)
        if let delegateObject = delegate {
            delegateObject.chargementTermine(type: "Succes")
        }
    }
}
