//
//  Constants.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

///ici on met tous les éléments de texte qui seront utilisés dans l'appli
public class Constants {
    ///éléments qui forment les requêtes
    struct Requete {
        static let BaseURL = "https://api.guildwars2.com/v2/achievements"
        static let Groupe = "groups"
        static let Categorie = "categories"
        static let Details = "ids"
    }
    
    ///éléments utilisés pour naviguer simplement dans les JSON retournés par l'API
    struct JsonKeys {
        static let id = "id"
        static let name = "name"
        static let description = "description"
        static let order = "order"
        static let categories = "categories"
        static let icon = "icon"
        static let achievements = "achievements"
        static let requirement = "requirement"
        static let locked_text = "locked_text"
        static let type = "type"
        static let flags = "flags"
    }
}
