//
//  ListeViewController.swift
//  GuildWar
//
//  Created by William Tomas on 12/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

class ListeViewController: UIViewController, ChargementDelegate {
    
    var etat: String = ""
    
    @IBOutlet weak var laListe: UITableView!

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
         laListe.dataSource = self
         laListe.delegate = self
        
         let nib = UINib(nibName: "Cellule", bundle: nil)
         laListe.register(nib, forCellReuseIdentifier: "Cellule")
        
     }
    
    func afficherElements(type: String) {
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
        
        print("etat:" + etat)
        
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
         /*let groupe = GroupService.shared.lesGroupes[indexPath.row]
        
         cell.textLabel?.text = element.name
         cell.detailTextLabel?.text = groupe.description*/
        
         return cell
     }
}
