//
//  Navigation.swift
//  GuildWar
//
//  Created by William Tomas on 24/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit
/**
ViewController principal de l'application, appelé automatiquement par le navigation controler
C'est ici que l'on appel les chargements depuis les services API et que l'on déclenche l'affichage des vues.
Implémente AffichageDelegate et ChargementDelegate
*/
class Navigation: UIViewController, AffichageDelegate, ChargementDelegate {
    
    var vueDetail: Detail!
    
    let service = ServiceAPI()
    
    /**
    Fonction viewDIdLoad, on initialise ici le premier chargement de l'applcation pour les groupes
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        chargerElement(type: Constants.Etat.groupe, elem: nil)
        
        service.delegate = self
    }
    
    /**
     Fonction afficherListe, permet d'afficher la liste avec les éléments adéquats en fonction de l'état de l'appli
     - parameter etat: l'état de navigation de l'application, de type String
     */
    func afficherListe(etat: String) {
        let vueListe = ListeViewController(nibName: "ListeViewController", bundle: nil)
        vueListe.delegate = self
        vueListe.etat = etat
        vueListe.view.accessibilityIdentifier = etat
        navigationController?.pushViewController(vueListe, animated: true)
        vueListe.navigationItem.title = etat
        if etat == Constants.Etat.groupe { //pour empêcher le retour vers le rootViewController
            vueListe.navigationItem.setHidesBackButton(true, animated:true)
        }
    }
    
    /**
     Fonction chargementTermine, délégué appelé par le serviceAPI
     Affiche la bonne liste avec le bon état, utilisation de la fonction pushViewController pour l'animation
     - parameter type: l'état dans lequel se trouve la vue liste, de type String
     */
    func chargementTermine(type: String) {
        switch type {
        case Constants.Etat.groupe :
            self.afficherListe(etat: Constants.Etat.groupe)
        case Constants.Etat.categorie :
            self.afficherListe(etat: Constants.Etat.categorie)
        case Constants.Etat.succes :
            self.afficherListe(etat: Constants.Etat.succes)
        default :
            print ("erreur switch navigation")
        }
    }
    
    /**
     Fonction chargerElement, délégué appelé par la liste lorsque une cellule est touchée.
     Appel les bonnes fonctions de services API, en fonction de l'état de l'application
     - parameter type: l'état dans lequel se trouve la vue liste, de type string
     - parameter elem: les éléments à passer pour le chargements des données, ce sont les tableaux contenant les ids des categories ou des succès que l'on souhaite récupérer.
     */
    func chargerElement(type: String, elem: [Int]?) {
        switch type {
        case Constants.Etat.groupe :
            GroupHelpers.shared.resetGroupe()
            service.getGroupe()
        case Constants.Etat.categorie :
            CategorieHelpers.shared.resetCategorie()
            service.getCategorie(ids: elem!)
        case Constants.Etat.succes :
            SuccesHelpers.shared.resetSucces()
            service.getListeSucces(ids: elem!)
        default :
            print ("erreur chargerElement")
        }
    }
    
    /**
     Fonction d'affichage de la vue détail
     On itialise ici l'objet de la classe Detail de type Succes.
     On ajoute une animation pour l'apparition de la vue.
     Implémente AffichageDelegate
     - parameter succes: l'id du succes que l'on souhaite afficher, de type Int
     */
    func chargerDetails(succes: Int) {
        self.vueDetail = Detail(nibName: Constants.Etat.detail, bundle: nil)
        self.vueDetail.objet = SuccesHelpers.shared.getSucces(id: succes)
        self.vueDetail.view.accessibilityIdentifier = Constants.Etat.detail
        navigationController?.pushViewController(self.vueDetail, animated: true)
        self.vueDetail.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSucces(_:)))
        self.vueDetail.navigationItem.title = SuccesHelpers.shared.getSucces(id: succes).name;
    }
    
    /**
     Fonction pour mettre en place la possibilité de partage
     Applique des éléments de popoverPresentationController pour a-bien afficher la bulle sous le bouton à droite dans le header
     */
    @objc func shareSucces(_ sender: UIBarButtonItem) {
        if let obj = self.vueDetail.objet {
            let text = "Voir le succès Guildwars 2 suivant : " + obj.name
            
            let textToShare = [ text ]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.barButtonItem = self.vueDetail.navigationItem.rightBarButtonItem
            activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up;
            
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
}
