//
//  DetailService.swift
//  GuildWar
//
//  Created by William Tomas on 14/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import Foundation

class SuccesService {
    static let shared = SuccesService()
    
    private init() {}
    
    private(set) var lesSucces: [Succes] = []
    
    func add(succes: Succes) {
        lesSucces.append(succes)
    }
    
    func getLesSucces() -> [Succes] {
        return lesSucces
    }
    
    func getSucces(id: Int) -> Succes {
        return lesSucces[id]
    }
    
    func getSuccesCount() -> Int {
        return lesSucces.count
    }
}
