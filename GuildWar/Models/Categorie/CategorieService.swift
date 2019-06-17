//
//  File.swift
//  GuildWar
//
//  Created by William Tomas on 13/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

class CategorieService {
    static let shared = CategorieService()
    
    private init() {}
    
    private(set) var lesCategories: [Categorie] = []
    
    func add(categorie: Categorie) {
        lesCategories.append(categorie)
    }
    
    func getCategorie() -> [Categorie] {
        return lesCategories
    }
    
    func getCategorie(id: Int) -> Categorie {
        return lesCategories[id]
    }
    
    func getCategorieCount() -> Int {
        return lesCategories.count
    }
}
