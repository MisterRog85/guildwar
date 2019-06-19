//
//  Detail.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

class Detail: UIViewController {
    
    @IBOutlet weak var monImage: UIImageView!
    @IBOutlet weak var monTitre: UILabel!
    @IBOutlet weak var maDescription: UILabel!
    @IBOutlet weak var mesRequirements: UILabel!
    
    public var objet: Succes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if objet != nil {
            self.monTitre?.text = objet.name
            self.maDescription?.text = objet.description
            self.mesRequirements?.text = objet.requirement
        } else {
            self.monTitre?.text = "Coucou"
            self.maDescription?.text = "lorem ipsum"
            self.mesRequirements?.text = "etgsdfgsdgsgserbsddgsetr"
        }
    }
    
    
    
    
}

