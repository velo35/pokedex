//
//  PokemonService.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation
import Siesta
import SwiftyJSON

enum PSEntriesError: Error
{
    case request
    case response
    case decode
}

enum PSPokemonError: Error
{
    case request
    case response
    case decode(String)
}

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
        super.init(baseURL: "https://pokeapi.co/api/v2")
        
        let decoder = JSONDecoder()
        
        configureTransformer("/pokemon", atStage: .parsing) {
            try decoder.decode(PokemonEntries.self, from: $0.content)
        }
        
        configureTransformer("/pokemon", atStage: .model) {
            ($0.content as PokemonEntries).results
        }
        
        SiestaLog.Category.enabled = .common
    }
    
    var pokemonEntries: Resource { resource("/pokemon") }
    
    func getPokemonEntries() async throws -> [PokemonEntry]
    {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")!
        guard let (data, response) = try? await URLSession.shared.data(from: url) else {
            throw PSEntriesError.request
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PSEntriesError.response
        }
        guard let pokemonEntries = try? JSONDecoder().decode(PokemonEntries.self, from: data) else {
            throw PSEntriesError.decode
        }
        return pokemonEntries.results
    }
    
    func getPokemon(for entry: PokemonEntry) async throws -> Pokemon
    {
        guard let (data, response) = try? await URLSession.shared.data(from: entry.url) else {
            throw PSPokemonError.request
        }
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw PSPokemonError.response
        }
        guard let json = try? JSON(data: data) else { throw PSPokemonError.decode("json") }
        guard let name = json["name"].string else { throw PSPokemonError.decode("name") }
        guard let type = json["types", 0, "type", "name"].string else { throw PSPokemonError.decode("type") }
        guard let imageUrl = json["sprites", "other", "official-artwork", "front_default"].url else { throw PSPokemonError.decode("image url") }
        return Pokemon(name: name, type: type, imageUrl: imageUrl)
    }
}
