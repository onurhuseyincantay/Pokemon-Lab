//
//  pokeCellCollectionViewCell.swift
//  PokemanLab
//
//  Created by onur hüseyin çantay on 23/07/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import UIKit

class pokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    
    var pokemon : Pokemon!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    func configureCell(_ pokemon : Pokemon){
        self.pokemon = pokemon
        lblName.text = self.pokemon.name.capitalized
        
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
