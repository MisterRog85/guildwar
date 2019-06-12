//
//  GroupService.swift
//  GuildWar
//
//  Created by William Tomas on 12/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

class GroupService {
    static let shared = GroupService()
    
    private init() {}
    
    private(set) var lesGroupes: [Groupe] = []
    
    func add(groupe: Groupe) {
        lesGroupes.append(groupe)
    }
    
    func getGroupes() -> [Groupe] {
        return lesGroupes
    }
    
    func getGroupe(id: Int) -> Groupe {
        return lesGroupes[id]
    }
    
    func getGroupeCount() -> Int {
        return lesGroupes.count
    }
}
