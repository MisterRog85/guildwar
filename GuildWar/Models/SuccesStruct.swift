//
//  DetailStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

struct Succes: Decodable {
    var id: Int
    var name: String
    var description: String?
    var requirement: String?
    var locked_text: String?
    var type: String?
    var flags: [String]
}
