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

struct GroupeComplexe: Decodable {
    let id: String
    let name: String
    let description: String
    let order: Int
    let categorie: [Int]
}
