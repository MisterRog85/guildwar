//
//  GroupService.swift
//  GuildWar
//
//  Created by William Tomas on 12/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

/**
 Les méthodes pour l'objet Groupe
 */
class GroupService {
    /// permet d'appeler le init() d'où on veut
    static let shared = GroupService()
    
    ///init
    private init() {}
    
    ///le tableau qui contiendra tous les groupes
    private(set) var lesGroupes: [Groupe] = []
    
    /**
     Fonction pour ajouter un élément au tableau
     - parameter groupe: un objet de type groupe
     */
    func add(groupe: Groupe) {
        lesGroupes.append(groupe)
    }
    
    /**
     Fonction qui renvoie tout le tableau
     - returns: le tableau
     */
    func getGroupes() -> [Groupe] {
        return lesGroupes
    }
    
    /**
     Fonction qui renvoie un élément particulier du tableau
     - parameter id: l'id représente la case voulue dans le tableau, de type int
     - returns: un objet de type groupe
     */
    func getGroupe(id: Int) -> Groupe {
        return lesGroupes[id]
    }
    
    /**
     Fonction qui renvoie le nombre d'élément du tableau
     - returns: le nombre d'éléments de type int
     */
    func getGroupeCount() -> Int {
        return lesGroupes.count
    }
    
    /**
     Fonction pour vider le tableau
     */
    func resetGroupe() {
        lesGroupes.removeAll()
    }
}
