//
//  ViewController.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
    
    @IBOutlet var maVue: UIView!
    
    var vueListe: ListeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vueListe = ListeViewController(nibName: "ListeViewController", bundle: nil)
        self.view.addSubview(vueListe.view)
        self.vueListe.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
        let service = ServiceAPI()
        service.delegate  = self.vueListe
        //service.getGroupe()
        //service.getCategorie(ids: [1, 3, 5])
        service.getListeSucces(ids: [1, 4, 5])
    }
}

