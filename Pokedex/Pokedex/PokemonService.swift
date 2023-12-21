//
//  PokemonService.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation
import Siesta
import SwiftyJSON

struct PokemonEntry: Identifiable, Codable
{
    let name: String
    let url: URL
    
    var id: URL { url }
}

struct PokemonEntries: Codable
{
    let count: Int
    let results: [PokemonEntry]
}

extension PokemonEntry
{
    static let bulbasaur = PokemonEntry(name: "bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!)
}

class PokemonService: Service
{
    static let shared = PokemonService()
    
    private init()
    {
        super.init(baseURL: "https://pokeapi.co")
        
        let decoder = JSONDecoder()
        
        configureTransformer("/api/v2/pokemon", atStage: .parsing) {
            try decoder.decode(PokemonEntries.self, from: $0.content)
        }
        
        configureTransformer("/api/v2/pokemon/*", atStage: .parsing) {
            try JSON(data: $0.content)
        }
        
        configureTransformer("/api/v2/pokemon/*") { entity -> Pokemon? in
            Pokedex.pokemon(from: entity.content)
        }
    }
    
    func pokemonEntries(for range: Range<Int>) -> Resource { resource("/api/v2/pokemon").withParams(["offset" : "\(range.lowerBound)", "limit": "\(range.upperBound - range.lowerBound)"]) }
    
    func pokemon(for entry: PokemonEntry) -> Resource { resource(entry.url.path) }
}

fileprivate func pokemon(from json: JSON) -> Pokemon
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
    return Pokemon(name: name, type: type, height: height, attack: attack, defense: defense, speed: speed, weight: weight, imageUrl: imageUrl)
}
