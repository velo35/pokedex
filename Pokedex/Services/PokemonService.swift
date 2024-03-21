//
//  PokemonService.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation
import Siesta

class PokemonService: Service
{
    static let shared = PokemonService()
    
    struct PokemonRequest: Codable
    {
        let count: Int
        let results: [PokemonEntry]
    }
    
    private init()
    {
        super.init(baseURL: "https://pokeapi.co/api/v2")
        
        configureTransformer("/pokemon", atStage: .parsing) { entity -> PokemonRequest in
            try JSONDecoder().decode(PokemonRequest.self, from: entity.content)
        }
        
        self.configure("/pokemon/*") {
            $0.pipeline[.parsing].removeTransformers()
        }
        
        configureTransformer("/pokemon/*") { entity -> Pokemon? in
            Pokemon(from: entity.content)
        }
        
//        SiestaLog.Category.enabled = .all
    }
    
    func pokemonEntries(for range: Range<Int>) -> Resource { resource("/pokemon").withParams(["offset" : "\(range.lowerBound)", "limit": "\(range.upperBound - range.lowerBound)"]) }
    
    func pokemon(for entry: PokemonEntry) -> Resource { resource("/pokemon").child(entry.name) }
    func image(for pokemon: Pokemon) -> Resource { resource(absoluteURL: pokemon.imageUrl) }
}
