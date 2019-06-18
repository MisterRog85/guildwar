//
//  ListeViewController.swift
//  GuildWar
//
//  Created by William Tomas on 12/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

protocol AffichageDelegate {
    func afficherElements(type: String, elem: [Int]?)
}

class ListeViewController: UIViewController, ChargementDelegate {
    
    var delegate: AffichageDelegate?
    
    var etat: String = ""
    
    @IBOutlet weak var laListe: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        laListe.dataSource = self
        laListe.delegate = self
        
        let nib = UINib(nibName: "Cellule", bundle: nil)
        laListe.register(nib, forCellReuseIdentifier: "Cellule")
    }
    
    func chargerElement(type: String) {
        etat = type
        laListe.reloadData()
        print ("appel delegate")
    }

}

extension ListeViewController: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var taille: Int = 0
        switch etat {
        case "Groupe":
            taille = GroupService.shared.getGroupeCount()
        case "Categorie":
            taille = CategorieService.shared.getCategorieCount()
        case "Succes":
            taille = SuccesService.shared.getSuccesCount()
        default:
            print ("erreur switch")
        }
        return taille
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellule", for: indexPath) as! Cellule
        
        //a ameliorer
        switch etat {
        case "Groupe":
            let element = GroupService.shared.lesGroupes[indexPath.row]
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
        case "Categorie":
            let element = CategorieService.shared.lesCategories[indexPath.row]
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
        case "Succes":
            let element = SuccesService.shared.lesSucces[indexPath.row]
            cell.textLabel?.text = element.name
            cell.detailTextLabel?.text = element.description
        default:
            print ("erreur de le switch de reload")
        }
        
         return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch etat {
            case "Groupe" :
                if let delegateObject = delegate {
                    delegateObject.afficherElements(type: "Categorie", elem: GroupService.shared.getGroupe(id: indexPath.row).categorie)
                }
            case "Categorie" :
                if let delegateObject = delegate {
                    delegateObject.afficherElements(type: "Succes", elem: CategorieService.shared.getCategorie(id: indexPath.row).achievements)
                }
            case "Succes" :
                print("on affiche le detail d'un succès")
            default :
                print("erreur switch ListViewController")
        }
    }
}
