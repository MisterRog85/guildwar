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
    
    ///éléments qui définissent l'état de l'application
    struct Etat {
        static let groupe = "Groupe"
        static let categorie = "Categorie"
        static let succes = "Succes"
        static let detail = "Detail"
        static let cellule = "Cellule"
    }
}
