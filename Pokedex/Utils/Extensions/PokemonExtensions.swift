//
//  PokemonExtensions.swift
//  Pokedex
//
//  Created by Scott Daniel on 3/21/24.
//

import Foundation
import SwiftyJSON

enum PokemonError: Error
{
    case decoding(String)
}

extension Pokemon
{
    init(from data: Data) throws
    {
        let json = try JSON(data: data)
        guard let name = json["name"].string else { throw PokemonError.decoding("name") }
        guard let typeString = json["types", 0, "type", "name"].string else { throw PokemonError.decoding("typeString") }
        guard let type = PokemonType(rawValue: typeString) else { throw PokemonError.decoding("type") }
        guard let height = json["height"].int else { throw PokemonError.decoding("height") }
        guard let attack = json["stats"].array?.first(where: { $0["stat", "name"].string == "attack" })?["base_stat"].int else { throw PokemonError.decoding("attack") }
        guard let defense = json["stats"].array?.first(where: { $0["stat", "name"].string == "defense" })?["base_stat"].int else { throw PokemonError.decoding("defense") }
        guard let speed = json["stats"].array?.first(where: { $0["stat", "name"].string == "speed" })?["base_stat"].int else { throw PokemonError.decoding("speed") }
        guard let weight = json["weight"].int else { throw PokemonError.decoding("weight") }
        guard let imageUrl = json["sprites", "other", "official-artwork", "front_default"].url ?? json["sprites", "front_default"].url else { throw PokemonError.decoding("image") }
        self.init(name: name, type: type, height: height, attack: attack, defense: defense, speed: speed, weight: weight, imageUrl: imageUrl)
    }
}
