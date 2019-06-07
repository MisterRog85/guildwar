//
//  DetailStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

struct detail: Decodable {
    let id: Int
    let name: String
    let description: String?
    let requirement: String
    let locked_text: String?
    let type: String?
    let flags: [String]
    
}
