//
//  Api.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation
import Moya
/**
 Enum pour l'API, propose 5 appels différents
 ** groupe pour récupérer un seul groupe
 ** groupeComplet pour récuperer tous les groupes
 ** categories pour récuperer toutes les catégories
 ** listeSucces pour récuperer la liste des succès
 ** detail pour récuperer les détails d'un succès particulier
 */
public enum Guildwar {
    case groupe
    case groupeComplet(idGroupe: String)
    case categorie(idCat: Int)
    case listeSucces(ids: String)
    case detail(idDet: Int)
}

///ici on gère les appels vers l'API en utilisant la bibliothèque Moya
extension Guildwar: TargetType {
    ///création de l'URL de base
    public var baseURL: URL {
        return URL(string: Constants.Requete.BaseURL)!
    }
    
    ///complément pour l'URL, on passe les paramètres ici (sauf pour listeSucces
    public var path: String {
        switch self {
            case .groupe: return "/"+Constants.Requete.Groupe
            case .groupeComplet(let idGroupe): return "/"+Constants.Requete.Groupe+"/"+idGroupe
            case .categorie(let idCat): return "/"+Constants.Requete.Categorie+"/"+String(idCat)
            case .listeSucces(_): return ""
            case .detail(let idDet): return "?"+Constants.Requete.Details+String(idDet)
        }
    }
    
    ///déclare la méthode de la requête, dans notre cas elles sont toutes en GET
    public var method: Moya.Method {
        switch self {
        case .groupe: return .get
        case .groupeComplet(_): return .get
        case .categorie(_): return .get
        case .listeSucces(_): return .get
        case .detail(_): return .get
        }
    }
    
    ///servira pour les données renvoyées par le serveur
    public var sampleData: Data {
        return Data()
    }
    
    ///permet de créer le complément pour l'URL lors de l'appel de liste succès (on met tous les ids les uns à la suite des autres séparés par une virgule)
    public var task: Task {
        switch self {
        case .listeSucces(let ids):
            var params: [String: Any] = [:]
            params[Constants.Requete.Details] = ids
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    ///défini les headers de la requête
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
