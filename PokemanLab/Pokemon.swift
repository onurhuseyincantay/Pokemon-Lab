//
//  Pokemon.swift
//  PokemanLab
//
//  Created by onur hüseyin çantay on 23/07/2017.
//  Copyright © 2017 onur hüseyin çantay. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon {
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvolotiontext : String!
    private var _pokemonURL : String!
    private var _nextEvoName : String!
    private var _nextEvoID : String!
    private var _nextEvolevel : String!
    var nextEvoID : String{
        if _nextEvoID == nil {
            _nextEvoID = ""
        }
        return _nextEvoID
    }
    var nextEvoLevel : String{
        if _nextEvolevel == nil {
            _nextEvolevel = ""
        }
        return _nextEvolevel
    }
    var nextEvoName : String{
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
   
    var description : String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    var defense : String{
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    var nextEvolutionText : String{
        if _nextEvolotiontext == nil {
            _nextEvolotiontext = ""
        }
        return _nextEvolotiontext
    }
    var name : String{
        return _name
    }
    var pokedexId : Int {
     return _pokedexId
    }
    init(name : String , pokedexId : Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
        
    }
    func downloadPokemonDetails(completed : @escaping DownloadComplete)  {
        Alamofire.request(self._pokemonURL).responseJSON{ response in
             if let dict = response.result.value as? Dictionary <String,AnyObject>{
                if let weight = dict ["weight"] as? String {
                    self._weight = weight
                    print(weight)
                }
                if let height = dict ["height"] as? String {
                    self._height = height
                    print(height)
                }
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                    print(attack)
                }
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                    print(defense)
                }
                if let types = dict ["types"] as? [Dictionary <String,AnyObject>], types.count > 0 {
                    if let tName = types [0]["name"]{
                        self._type = tName.capitalized
                    }
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types [x]["name"] {
                                self._type! += "/ \(name.capitalized!)"
                            }
                        }
                    }
                
                }else{
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] , descArr.count > 0 {
                    
                    if let url = descArr[0]["resource_uri"] {
                        
                        let descURL = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descURL).responseJSON(completionHandler: { (response) in
                            
                            if let descDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    print(newDescription)
                                }
                            }
                            
                            completed()
                        })
                    }
                } else {
                    
                    self._description = ""
                }
                if let evolutions = dict["evolutions"] as? [Dictionary <String,AnyObject>],evolutions.count > 0 {
                    if let nextEvo = evolutions[0]["to"] as? String {
                        if nextEvo.range(of: "mega") == nil {
                         self._nextEvoName = nextEvo
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let NextID = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvoID = NextID
                                if let lvlExist = evolutions[0]["level"]{
                                    if let level = lvlExist as? Int {
                                    self._nextEvolevel = "\(level)"
                                    }
                                }else{
                                    self._nextEvolevel = ""
                                }
                            }
                        }
                    }
                }
            
        completed()    
    }
        
}
}
}
