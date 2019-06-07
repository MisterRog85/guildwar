//
//  CategorieStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

struct categories : Decodable {
    let id: Int
    let name: String
    let description: String?
    let order: Int
    let icon: URL
    let achievements: [Int]
}
