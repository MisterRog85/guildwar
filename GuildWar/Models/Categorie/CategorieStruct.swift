//
//  CategorieStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

struct Categorie : Decodable {
    var id: Int
    var name: String
    var description: String?
    var order: Int
    var icon: URL
    var achievements: [Int]
}
