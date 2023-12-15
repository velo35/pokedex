//
//  PokemonService.swift
//  Pokedex
//
//  Created by Scott Daniel on 12/14/23.
//

import Foundation

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
    case decode
}

struct PokemonEntry: Codable
{
    let name: String
    let url: URL
}

struct PokemonEntries: Codable
{
    let results: [PokemonEntry]
}

class PokemonService
{
    static let shared = PokemonService()
    
    private init() {}
    
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
        guard let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) else {
            throw PSPokemonError.decode
        }
        return pokemon
    }
}
