//
//  ViewController.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController, AffichageDelegate {
    
    @IBOutlet var maVue: UIView!
    
    var vueListe: ListeViewController!
    
    let service = ServiceAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vueListe = ListeViewController(nibName: "ListeViewController", bundle: nil)
        self.view.addSubview(vueListe.view)
        self.vueListe.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.vueListe.delegate = self
        
        service.delegate  = self.vueListe
        service.getGroupe()
        //service.getCategorie(ids: [1, 3, 5])
        //service.getListeSucces(ids: [1, 4, 5])
    }
    
    func afficherElements(type: String, elem: [Int]?) {
        print ("switch view controller")
        switch type {
        case "Groupe":
            self.service.getGroupe()
        case "Categorie":
            self.service.getCategorie(ids: elem!)
        case "Succes":
            self.service.getListeSucces(ids: elem!)
        default:
            print ("erreur chargement switch ViewController")
        }
    }
}

