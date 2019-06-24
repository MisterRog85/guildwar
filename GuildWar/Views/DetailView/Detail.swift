//
//  Detail.swift
//  GuildWar
//
//  Created by William Tomas on 05/06/2019.
//  Copyright © 2019 William Tomas. All rights reserved.
//

import UIKit

///Protocol pour la suppression de la vue détail, la fonction est implémenté dans le ViewController
protocol SuppressionDelegate {
    func supprimerDetails()
}

/**
 Classe pour la gestion de la vue du détail d'un succès, de type UIViewController
 Comprend la fonctionnalité de partage
 */
class Detail: UIViewController {
    
    ///les outlets consituant la vue
    @IBOutlet weak var monImage: UIImageView!
    @IBOutlet weak var monTitre: UILabel!
    @IBOutlet weak var maDescription: UILabel!
    @IBOutlet weak var mesRequirements: UILabel!
    @IBOutlet weak var Close: UIButton!
    
    ///la variable de type objet qui contiendra les informations du succès que l'on souhaite afficher en détail
    public var objet: Succes!
    
    var delegate: SuppressionDelegate?
    
    /**
     La fonction viewDidLoad, c'est ici que l'on défini le contenu des éléments qui sont affichés.
     L'affichage des valeurs ne se fait que si l'élément objet a été initialisé avec des valeurs
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if objet != nil {
            self.monTitre?.text = objet.name
            self.maDescription?.text = objet.description
            self.mesRequirements?.text = objet.requirement
        }
    }
    
    ///Action relié à un bouton pour fermer la vue, appel du délégué
    @IBAction func closeView(sender: UIButton) {
        if let delegateObject = delegate {
            delegateObject.supprimerDetails()
        }
    }
    
    ///Fonction pour partager le succès visualisé
    @IBAction func shareTextButton(_ sender: UIButton) {
        let text = "Voir le succès Guildwars 2 suivant : "+objet.name
        
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
}

