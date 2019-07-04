//
//  ListeViewController.swift
//  GuildWar
//
//  Created by William Tomas on 12/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

/**
 Protocol pour le délégué d'affichage (les fonctions sont dans le ViewController)
 */
protocol AffichageDelegate {
    func chargerElement(type: String, elem: [Int]?)
    func chargerDetails(succes: Int)
}

/**
 Classe pour gérer la vue liste. La vue liste est utilisée pour afficher les groupes, les catégories et les succés. Implémente le ChargemtnDelegate
 */
class ListeViewController: UIViewController {
    
    var delegate: AffichageDelegate?
    
    ///variable qui contiendra l'état d'affichage en cours de la liste (groupe, catégorie ou succès)
    var etat: String = ""
    
    ///L'élément de type UITableView
    @IBOutlet weak var laListe: UITableView!
    
    /**
     La fonction viewDidLoad
     On implémente la source de données (datasource) et le délégué(delegate) de la liste ici.
     On incorpore un élément de type cellule dans la liste ici.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laListe.dataSource = self
        laListe.delegate = self
        
        let nib = UINib(nibName: Constants.Etat.cellule, bundle: nil)
        laListe.register(nib, forCellReuseIdentifier: Constants.Etat.cellule)
    }
    
    /**
     Fonction pour recharger les éléments qui seront affichés dans la liste
     On introduit un effet de transition.
     */
    func chargementTermine(type: String) {
        etat = type
        UIView.transition(with: laListe,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.laListe.reloadData() })
    }

}

/**
 Extension de la classe ListeViewController, implémente le datasource et le délégué
 */
extension ListeViewController: UITableViewDataSource, UITableViewDelegate {
    
    ///définition du nombre de sections de la liste
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
    
    ///définition du nombre de ligne dans la liste en fonction de la longueur du tableau d'un élément particulier
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var taille: Int = 0
        switch etat {
        case Constants.Etat.groupe:
            taille = GroupHelpers.shared.getGroupeCount()
        case Constants.Etat.categorie:
            taille = CategorieHelpers.shared.getCategorieCount()
        case Constants.Etat.succes:
            taille = SuccesHelpers.shared.getSuccesCount()
        default:
            print ("erreur switch")
        }
        return taille
     }
    
    ///C'est ici que l'on rempli la cellule avec les informations issues d'un élément particulier
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Etat.cellule, for: indexPath) as! Cellule

        //a ameliorer
        switch etat {
        case Constants.Etat.groupe:
            let element = GroupHelpers.shared.lesGroupes[indexPath.row]
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
        case Constants.Etat.categorie:
            let element = CategorieHelpers.shared.lesCategories[indexPath.row]
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
        case Constants.Etat.succes:
            let element = SuccesHelpers.shared.lesSucces[indexPath.row]
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
        default:
            print ("erreur de le switch de reload")
        }
        
         return cell
     }
    
    ///fonction d'écoute de l'interaction entre l'utilisateur et la liste. En cas d'appuie et en fonction de l'état dans lequel se situe la liste on déclenche une action particulière
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch etat {
            case Constants.Etat.groupe :
                if let delegateObject = delegate {
                    delegateObject.chargerElement(type: Constants.Etat.categorie, elem: GroupHelpers.shared.getGroupe(id: indexPath.row).categories)
                }
            case Constants.Etat.categorie :
                if let delegateObject = delegate {
                    delegateObject.chargerElement(type: Constants.Etat.succes, elem: CategorieHelpers.shared.getCategorie(id: indexPath.row).achievements)
                }
            case Constants.Etat.succes :
                if let delegateObject = delegate {
                    delegateObject.chargerDetails(succes: indexPath.row)
                }
            default :
                print("erreur switch ListViewController")
        }
    }
}
