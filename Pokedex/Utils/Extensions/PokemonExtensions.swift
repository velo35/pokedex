//
//  PokemonExtensions.swift
//  Pokedex
//
//  Created by Scott Daniel on 3/21/24.
//

import Foundation
import SwiftyJSON

extension Pokemon
{
    init?(from data: Data)
    {
        guard let json = try? JSON(data: data) else { return nil }
        guard let name = json["name"].string else { print("Pokemon: name"); return nil }
        guard let typeString = json["types", 0, "type", "name"].string else { print("Pokemon: \(name): typeString"); return nil }
        guard let type = PokemonType(rawValue: typeString) else { print("Pokemon: \(name): type"); return nil }
        guard let height = json["height"].int else { print("Pokemon: \(name): height"); return nil }
        guard let attack = json["stats"].array?.first(where: { $0["stat", "name"].string == "attack" })?["base_stat"].int else { print("Pokemon: \(name): attack"); return nil }
        guard let defense = json["stats"].array?.first(where: { $0["stat", "name"].string == "defense" })?["base_stat"].int else { print("Pokemon: \(name): defense"); return nil }
        guard let speed = json["stats"].array?.first(where: { $0["stat", "name"].string == "speed" })?["base_stat"].int else { print("Pokemon: \(name): speed"); return nil }
        guard let weight = json["weight"].int else { print("Pokemon: \(name): weight"); return nil }
        guard let imageUrl = json["sprites", "other", "official-artwork", "front_default"].url ?? json["sprites", "front_default"].url else { print("Pokemon: \(name): image"); return nil }
        self.init(name: name, type: type, height: height, attack: attack, defense: defense, speed: speed, weight: weight, imageUrl: imageUrl)
    }
}
