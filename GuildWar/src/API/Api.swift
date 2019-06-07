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
    case categorie
    case detail
}

extension Guildwar: TargetType {
    public var baseURL: URL {
        return URL(string: Constants.Requete.BaseURL)!
    }
    
    public var path: String {
        switch self {
            case .groupe: return "/"+Constants.Requete.Groupe
            case .groupeComplet(let idGroupe): return "/"+Constants.Requete.Groupe+"/"+idGroupe
            case .categorie: return "/"+Constants.Requete.Categorie
            case .detail: return Constants.Requete.Details
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .groupe: return .get
        case .groupeComplet(_): return .get
        case .categorie: return .get
        case .detail: return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
