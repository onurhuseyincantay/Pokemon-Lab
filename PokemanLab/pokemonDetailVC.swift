//
//  pokemonDetailVC.swift
//  PokemanLab
//
//  Created by onur hüseyin çantay on 25/07/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class pokemonDetailVC : UIViewController {
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblDefense: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var lblBaseAttack: UILabel!
    @IBOutlet weak var lblPokeName: UILabel!
    @IBOutlet weak var imgCurrentEvo: UIImageView!
    @IBOutlet weak var imgNextEvo: UIImageView!
    @IBOutlet weak var lblEvo: UILabel!
    var pokemon : Pokemon!

    override func viewDidLoad() {
       super.viewDidLoad()
       lblPokeName.text = pokemon.name
        imgMain.image = UIImage(named: "\(pokemon.pokedexId)")
        pokemon.downloadPokemonDetails {
            print("buraya geldi")
            self.updateUI()
        }
    }
    @IBAction func btnBackPressed(_ sender: UIButton) {
    dismiss(animated: true, completion: nil)
    }
    func updateUI() {
        
        lblType.text = pokemon.type
        lblDefense.text = pokemon.defense
        lblHeight.text = pokemon.height
        lblWeight.text = pokemon.weight
        lblID.text = "\(pokemon.pokedexId)"
        imgCurrentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
        lblDescription.text = pokemon.description
        lblBaseAttack.text = pokemon.attack
        lblPokeName.text = pokemon.name
        if pokemon.nextEvoID == "" {
            lblEvo.text = "No Evolutions"
            imgNextEvo.isHidden = true
        }else {
            imgNextEvo.isHidden = false
            imgNextEvo.image = UIImage(named: "\(pokemon.nextEvoID)")
            let str = "Next Evolution : \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
            lblEvo.text = str
            
        }
        
        print(pokemon.type)
        print(pokemon.attack)
        
    }
   
}
