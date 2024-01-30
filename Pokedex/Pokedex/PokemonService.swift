//
//  PokemonService.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation
import Siesta
import SwiftyJSON

class PokemonService: Service
{
    static let shared = PokemonService()
    
    private init()
    {
        super.init(baseURL: "https://pokeapi.co/api/v2")
        
        configureTransformer("/pokemon", atStage: .parsing) {
            try JSON(data: $0.content)
        }
        
        configureTransformer("/pokemon") { entity -> [PokemonEntry] in
            (entity.content as JSON)["results"].arrayValue.map{ PokemonEntry(from: $0) }
        }
        
        configureTransformer("/pokemon/*", atStage: .parsing) {
            try JSON(data: $0.content)
        }
        
        configureTransformer("/pokemon/*") { entity -> Pokemon in
            Pokemon(from: entity.content)
        }
        
//        SiestaLog.Category.enabled = .all
    }
    
    func pokemonEntries(for range: Range<Int>) -> Resource { resource("/pokemon").withParams(["offset" : "\(range.lowerBound)", "limit": "\(range.upperBound - range.lowerBound)"]) }
    
    func pokemon(for entry: PokemonEntry) -> Resource { resource("/pokemon").child(entry.name) }
    func image(for pokemon: Pokemon) -> Resource { resource(absoluteURL: pokemon.imageUrl) }
}

extension PokemonEntry
{
    init(from json: JSON) 
    {
        guard let name = json["name"].string else { fatalError("name") }
        guard let url = json["url"].url else { fatalError("url") }
        self.init(name: name, url: url)
    }
}

extension Pokemon
{
    init(from json: JSON)
    {
        guard let name = json["name"].string else { fatalError("name") }
        guard let typeString = json["types", 0, "type", "name"].string else { fatalError("\(name): typeString") }
        guard let type = PokemonType(rawValue: typeString) else { fatalError("\(name): type") }
        guard let height = json["height"].int else { fatalError("\(name): type") }
        guard let attack = json["stats"].array?.first(where: { $0["stat", "name"].string == "attack" })?["base_stat"].int else { fatalError("\(name): attack") }
        guard let defense = json["stats"].array?.first(where: { $0["stat", "name"].string == "defense" })?["base_stat"].int else { fatalError("\(name): defense") }
        guard let speed = json["stats"].array?.first(where: { $0["stat", "name"].string == "speed" })?["base_stat"].int else { fatalError("\(name): speed") }
        guard let weight = json["weight"].int else { fatalError("\(name): weight") }
        guard let imageUrl = json["sprites", "other", "official-artwork", "front_default"].url else { fatalError("\(name): image") }
        self.init(name: name, type: type, height: height, attack: attack, defense: defense, speed: speed, weight: weight, imageUrl: imageUrl)
    }
}
