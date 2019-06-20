//
//  ViewController.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController, AffichageDelegate, SuppressionDelegate {
    
    @IBOutlet var maVue: UIView!
    
    var vueListe: ListeViewController!
    var vueDetail: Detail!
    
    let service = ServiceAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vueListe = ListeViewController(nibName: "ListeViewController", bundle: nil)
        self.view.addSubview(vueListe.view)
        self.vueListe.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.vueListe.delegate = self
        
        service.delegate  = self.vueListe
        service.getGroupe()        
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
    
    func chargerDetails(succes: Int) {
        self.vueDetail = Detail(nibName: "Detail", bundle: nil)
        self.vueDetail.objet = SuccesService.shared.getSucces(id: succes)
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(self.vueDetail.view)
        }, completion: nil)
        self.vueDetail.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.vueDetail.delegate = self
    }
    
    func supprimerDetails() {
        if self.vueDetail != nil {
            self.vueDetail.removeFromParent()
            self.viewDidLoad()
        }
    }
}

