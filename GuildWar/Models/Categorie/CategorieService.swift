//
//  File.swift
//  GuildWar
//
//  Created by William Tomas on 13/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

/**
 Les méthodes pour l'objet Catégorie
 */
class CategorieService {
    /// permet d'appeler le init() d'où on veut
    static let shared = CategorieService()
    
    ///init
    private init() {}
    
    ///le tableau qui contiendra toutes les categories
    private(set) var lesCategories: [Categorie] = []
    
    /**
     Fonction pour ajouter un élément au tableau
     - parameter categorie: un objet de type Categorie
     */
    func add(categorie: Categorie) {
        lesCategories.append(categorie)
    }
    
    /**
     Fonction qui renvoie tout le tableau
     - returns: le tableau
     */
    func getCategorie() -> [Categorie] {
        return lesCategories
    }
    
    /**
     Fonction qui renvoie un élément particulier du tableau
     - parameter id: l'id représente la case voulue dans le tableau, de type int
     - returns: un objet de type Categorie
     */
    func getCategorie(id: Int) -> Categorie {
        return lesCategories[id]
    }
    
    /**
     Fonction qui renvoie le nombre d'élément du tableau
     - returns: le nombre d'éléments de type int
     */
    func getCategorieCount() -> Int {
        return lesCategories.count
    }
    
    /**
     Fonction pour vider le tableau
     */
    func resetCategorie() {
        lesCategories.removeAll()
    }
}
