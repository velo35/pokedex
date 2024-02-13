//
//  PreviewData.swift
//  Pokedex
//
//  Created by Scott Daniel on 1/6/24.
//

import Foundation

extension PokemonEntry
{
    static let bulbasaur = PokemonEntry(name: "bulbasaur", url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!)
    static let squirtle = PokemonEntry(name: "squirtle", url: URL(string: "https://pokeapi.co/api/v2/pokemon/7/")!)
}

extension Pokemon
{
    static let bulbasaur = Pokemon(name: "bulbasaur",
                                   type: .grass,
                                   height: 7,
                                   attack: 49,
                                   defense: 49,
                                   speed: 45,
                                   weight: 69,
                                   imageUrl: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png")!)
}
