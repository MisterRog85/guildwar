//
//  Api.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation
import Moya

//ici on gère les appels vers l'API
public enum Guildwar {
    case groupe
    case groupeComplet(idGroupe: String)
    case categorie(idCat: Int)
    case listeSucces(ids: String)
    case detail(idDet: Int)
}

extension Guildwar: TargetType {
    public var baseURL: URL {
        return URL(string: Constants.Requete.BaseURL)!
    }
    
    public var path: String {
        switch self {
            case .groupe: return "/"+Constants.Requete.Groupe
            case .groupeComplet(let idGroupe): return "/"+Constants.Requete.Groupe+"/"+idGroupe
            case .categorie(let idCat): return "/"+Constants.Requete.Categorie+"/"+String(idCat)
            case .listeSucces(_): return ""
            case .detail(let idDet): return "?"+Constants.Requete.Details+String(idDet)
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .groupe: return .get
        case .groupeComplet(_): return .get
        case .categorie(_): return .get
        case .listeSucces(_): return .get
        case .detail(_): return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
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
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
