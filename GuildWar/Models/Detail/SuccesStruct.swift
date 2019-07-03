//
//  DetailStruct.swift
//  GuildWar
//
//  Created by William Tomas on 06/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

/**
 Structure pour l'objet Succes
 */
struct Succes: Codable {
    var id: Int
    var name: String
    var description: String?
    var requirement: String?
    var locked_text: String?
}
