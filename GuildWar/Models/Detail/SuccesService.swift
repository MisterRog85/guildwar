//
//  DetailService.swift
//  GuildWar
//
//  Created by William Tomas on 14/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

/**
 Les méthodes pour l'objet Succes
 */
class SuccesService {
    /// permet d'appeler le init() d'où on veut
    static let shared = SuccesService()
    
    ///init
    private init() {}
    
    ///le tableau qui contiendra toutes les success
    private(set) var lesSucces: [Succes] = []
    
    /**
     Fonction pour ajouter un élément au tableau
     - parameter succes: un objet de type Succes
     */
    func add(succes: Succes) {
        lesSucces.append(succes)
    }
    
    /**
     Fonction qui renvoie tout le tableau
     - returns: le tableau
     */
    func getLesSucces() -> [Succes] {
        return lesSucces
    }
    
    /**
     Fonction qui renvoie un élément particulier du tableau
     - parameter id: l'id correspondant à l'id de l'objet souhaité, DIFFERENT DE L'INDICE DE CASE DU TABLEAU
     - returns: un objet de type Succes
     */
    func getSucces(id: Int) -> Succes {
        var succes: Succes! = nil
        for i in 0..<(lesSucces.count-1) {
            if i == id {
                succes = Succes(id: lesSucces[i].id, name: lesSucces[i].name, description: lesSucces[i].description, requirement: lesSucces[i].requirement, locked_text: lesSucces[i].locked_text, type: lesSucces[i].type, flags: lesSucces[i].flags )
                break
            }
        }
        return succes
    }
    
    /**
     Fonction qui renvoie le nombre d'élément du tableau
     - returns: le nombre d'éléments de type int
     */
    func getSuccesCount() -> Int {
        return lesSucces.count
    }
    
    /**
     Fonction pour vider le tableau
     */
    func resetSucces() {
        lesSucces.removeAll()
    }
}
