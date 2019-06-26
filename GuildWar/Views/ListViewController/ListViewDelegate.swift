//
//  ListViewDelegate.swift
//  GuildWar
//
//  Created by William Tomas on 26/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

extension ListeViewController: UITableViewDataSource, UITableViewDelegate {
    
    /// fonction pour ajouter un header à la liste, qui contient le nom de l'état en cours d'affichage(Groupe, Catégories ou Succès
    /*func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
     if etat != "" {
     return etat
     } else {
     return "Guildwars"
     }
     }*/
    
    ///définition du nombre de sections de la liste
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ///définition du nombre de ligne dans la liste en fonction de la longueur du tableau d'un élément particulier
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
    
    ///C'est ici que l'on rempli la cellule avec les informations issues d'un élément particulier
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
    
    ///fonction d'écoute de l'interaction entre l'utilisateur et la liste. En cas d'appuie et en fonction de l'état dans lequel se situe la liste on déclenche une action particulière
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
            if let delegateObject = delegate {
                delegateObject.chargerDetails(succes: indexPath.row)
            }
        default :
            print("erreur switch ListViewController")
        }
    }
}
