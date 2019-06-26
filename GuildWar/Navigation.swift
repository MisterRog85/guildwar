//
//  Navigation.swift
//  GuildWar
//
//  Created by William Tomas on 24/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//


import UIKit

class Navigation: UIViewController, AffichageDelegate, ChargementDelegate {
    
    var vueDetail: Detail!
    
    let service = ServiceAPI()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chargerElement(type: "Groupe", elem: nil)
        
        service.delegate = self
        
    }
    
    func chargementTermine(type: String) {
        switch type {
        case "Groupe" :
            let vueGroupe = ListeViewController(nibName: "ListeViewController", bundle: nil)
            vueGroupe.delegate = self
            vueGroupe.etat = "Groupe"
            navigationController?.pushViewController(vueGroupe, animated: true)
            vueGroupe.navigationItem.title = "Groupe";
        case "Categorie" :
            let vueCat = ListeViewController(nibName: "ListeViewController", bundle: nil)
            vueCat.delegate = self
            vueCat.etat = "Categorie"
            navigationController?.pushViewController(vueCat, animated: true)
            vueCat.navigationItem.title = "Categorie";
        case "Succes" :
            let vueSuc = ListeViewController(nibName: "ListeViewController", bundle: nil)
            vueSuc.delegate = self
            vueSuc.etat = "Succes"
            navigationController?.pushViewController(vueSuc, animated: true)
            vueSuc.navigationItem.title = "Succes";
        default :
            print ("erreur switch navigation")
        }

    }
    
    func chargerElement(type: String, elem: [Int]?) {
        switch type {
        case "Groupe" :
            GroupService.shared.resetGroupe()
            service.getGroupe()
        case "Categorie" :
            CategorieService.shared.resetCategorie()
            service.getCategorie(ids: elem!)
        case "Succes" :
            SuccesService.shared.resetSucces()
            service.getListeSucces(ids: elem!)
        default :
            print ("erreur chargerElement")
        }
    }
    
    func chargerDetails(succes: Int) {
        self.vueDetail = Detail(nibName: "Detail", bundle: nil)
        self.vueDetail.objet = SuccesService.shared.getSucces(id: succes)
        navigationController?.pushViewController(self.vueDetail, animated: true)
        self.vueDetail.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSucces(_:)))
        self.vueDetail.navigationItem.title = SuccesService.shared.getSucces(id: succes).name;
    }
    
    @objc func shareSucces(_ sender: UIBarButtonItem) {
        let text = "Voir le succès Guildwars 2 suivant : "+self.vueDetail.objet.name
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.barButtonItem = self.vueDetail.navigationItem.rightBarButtonItem
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up;
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func buttonPressShowDetails(_ sender: UIButton) {
        //performSegue(withIdentifier: "SegueFromRootToFirst", sender: self)
        chargerElement(type: "Groupe", elem: nil)
        /*service.getGroupe()
        navigationController?.pushViewController(vueListe, animated: true)
        vueListe.navigationItem.title = "Groupe View";*/

    }
}
