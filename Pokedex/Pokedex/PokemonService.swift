//
//  PokemonService.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation
import Siesta
import SwiftyJSON

struct PokemonEntry: Codable
{
    let name: String
    let url: URL
}

extension PokemonEntry
{
    static let bulbasaur = PokemonEntry(name: "bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!)
}

class PokemonService: Service
{
    private struct PokemonEntries: Codable
    {
        let results: [PokemonEntry]
    }
    
    static let shared = PokemonService()
    
    private init() 
    {
        super.init(baseURL: "https://pokeapi.co")
        
        let decoder = JSONDecoder()
        
        configureTransformer("/api/v2/pokemon", atStage: .parsing) {
            try decoder.decode(PokemonEntries.self, from: $0.content)
        }
        
        configureTransformer("/api/v2/pokemon", atStage: .model) {
            ($0.content as PokemonEntries).results
        }
        
        configureTransformer("/api/v2/pokemon/*", atStage: .parsing) {
            try JSON(data: $0.content)
        }
        
        configureTransformer("/api/v2/pokemon/*", atStage: .model) { entity -> Pokemon? in
            let json: JSON = entity.content
            guard let name = json["name"].string,
                  let typeString = json["types", 0, "type", "name"].string,
                  let type = PokemonType(rawValue: typeString),
                  let imageUrl = json["sprites", "other", "official-artwork", "front_default"].url else { return nil }
            return Pokemon(name: name, type: type, imageUrl: imageUrl)
        }
        
//        SiestaLog.Category.enabled = .all
    }
    
    var pokemonEntries: Resource { resource("/api/v2/pokemon") }
    
    func pokemon(for entry: PokemonEntry) -> Resource { resource(entry.url.path) }
}
