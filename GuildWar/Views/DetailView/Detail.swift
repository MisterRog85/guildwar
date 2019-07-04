//
//  Detail.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

/**
 Classe pour la gestion de la vue du détail d'un succès, de type UIViewController
 Comprend la fonctionnalité de partage
 */
class Detail: UIViewController {
    
    ///les outlets consituant la vue
    @IBOutlet weak var monImage: UIImageView!
    @IBOutlet weak var monTitre: UILabel!
    @IBOutlet weak var maDescription: UILabel!
    @IBOutlet weak var mesRequirements: UILabel!
    
    ///la variable de type objet qui contiendra les informations du succès que l'on souhaite afficher en détail
    public var objet: Succes?
    
    /**
     La fonction viewDidLoad, c'est ici que l'on défini le contenu des éléments qui sont affichés.
     L'affichage des valeurs ne se fait que si l'élément objet a été initialisé avec des valeurs
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let obj = objet {
            self.monTitre?.text = obj.name
            self.maDescription?.text = obj.description
            self.mesRequirements?.text = obj.requirement
        }
    }

}

