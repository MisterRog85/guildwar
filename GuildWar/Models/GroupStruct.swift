//
//  GroupStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

struct GroupeSimple: Decodable {
    let id: String
}

struct GroupeComplexe {
    let id: String
    let name: String
    let description: String
    let order: Int
    let categorie: [Int]
    
    init(id: String? = nil, name: String? = nil, description: String? = nil, order: Int? = nil, categorie: [Int]? = nil) {
        self.id = id!
        self.name = name!
        self.description = description!
        self.order = order!
        self.categorie = categorie!
    }
}
