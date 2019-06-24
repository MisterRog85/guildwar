//
//  ViewController.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit
import Moya

/**
 ViewController principal de l'application, c'est ici que l'on charge les vues et que l'on ordonne leur mise à jour en déclenchant les appels API.
 Implémente AffichageDelegate et SuppressionDelegate.
 */
class ViewController: UIViewController, AffichageDelegate, SuppressionDelegate {
    
    @IBOutlet var maVue: UIView!
    
    ///Les objets du type de mes vues
    var vueListe: ListeViewController!
    var vueDetail: Detail!
    
    ///On initialise la partie service vers l'API de l'application
    let service = ServiceAPI()
    
    /**
     Fonction ViewDidLoad du viewController, c'est ici que l'on ajoute à la vue le nib contenant la vue liste. On lance aussi le premier appel service qui récupère la liste des groupes
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.vueListe = ListeViewController(nibName: "ListeViewController", bundle: nil)
        self.view.addSubview(vueListe.view)
        self.vueListe.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.vueListe.delegate = self
        
        service.delegate  = self.vueListe
        if GroupService.shared.getGroupeCount() != 0 {
            GroupService.shared.resetGroupe()
            CategorieService.shared.resetCategorie()
            SuccesService.shared.resetSucces()
        }
        service.getGroupe()
    }
    
    /**
     Fonction qui appel le chargement de certains éléments en fonction de l'état dans lequel se trouve la vue liste.
     Fonction implémentant le AffichageDelegate.
     - parameter type: l'état dans lequel se trouve la vue liste, de type string
     - parameter elem: les éléments à passer pour le chargements des données, ce sont les tableaux contenant les ids des categories ou des succès que l'on souhaite récupérer.
     */
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
    
    /**
     Fonction permettant le chargment de la vue détail pour un succès. On utilise là encore l'ajout de vue à la vue principale avec la méthode addSubView.
     On itialise ici l'objet de la classe Detail de type Succes.
     On ajoute une animation pour l'apparition de la vue.
     Implémente AffichageDelegate
     - parameter succes: l'id du succes que l'on souhaite afficher, de type Int
     */
    func chargerDetails(succes: Int) {
        self.vueDetail = Detail(nibName: "Detail", bundle: nil)
        self.vueDetail.objet = SuccesService.shared.getSucces(id: succes)
        UIView.transition(with: self.view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(self.vueDetail.view)
        }, completion: nil)
        self.vueDetail.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.vueDetail.delegate = self
    }
    
    /**
     Fonction permettant la suppression de la vue détail de la vue principale. On utilise la méthode removeFromParent.
     On réinitialise la vue avec la liste au point de départ (affichage des groupes)
     Implémente SuppressionDelegate
     */
    func supprimerDetails() {
        if self.vueDetail != nil {
            self.vueDetail.removeFromParent()
            self.viewDidLoad()
        }
    }
}

