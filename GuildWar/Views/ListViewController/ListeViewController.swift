//
//  ListeViewController.swift
//  GuildWar
//
//  Created by William Tomas on 12/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

class ListeViewController: UIViewController, ChargementDelegate {
    
    @IBOutlet weak var laListe: UITableView!

    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
         laListe.dataSource = self
         laListe.delegate = self
        
         let nib = UINib(nibName: "Cellule", bundle: nil)
         laListe.register(nib, forCellReuseIdentifier: "Cellule")
        
         let service = ServiceAPI()
         service.delegate  = self
         service.getGroupe()
     }
    
    func afficherElements() {
        laListe.reloadData()
        print ("appel delegate")
    }

}

extension ListeViewController: UITableViewDataSource, UITableViewDelegate {
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
     }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GroupService.shared.getGroupeCount()
     }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cellule", for: indexPath) as! Cellule
        
         let groupe = GroupService.shared.lesGroupes[indexPath.row]
        
         cell.textLabel?.text = groupe.name
         cell.detailTextLabel?.text = groupe.description
        
         return cell
     }
}
