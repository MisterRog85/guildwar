//
//  GroupStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

/**
 Structure pour l'objet Groupe
 */
struct Groupe: Codable {
    var id: String
    var name: String
    var description: String
    var order: Int
    var categories: [Int]
}

