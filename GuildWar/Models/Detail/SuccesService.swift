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
        var succes: Succes! = nil
        for i in 0..<(lesSucces.count-1) {
            if i == id {
                succes = Succes(id: lesSucces[i].id, name: lesSucces[i].name, description: lesSucces[i].description, requirement: lesSucces[i].requirement, locked_text: lesSucces[i].locked_text, type: lesSucces[i].type, flags: lesSucces[i].flags )
                break
            }
        }
        return succes
    }
    
    func getSuccesCount() -> Int {
        return lesSucces.count
    }
}
