//
//  PokedexCell.swift
//  Pokedex_UIKit
//
//  Created by Scott Daniel on 1/16/24.
//

import UIKit
import Siesta

class PokedexCell: UICollectionViewCell, ResourceObserver
{
    func resourceChanged(_ resource: Siesta.Resource, event: Siesta.ResourceEvent) 
    {
        self.image.image = resource.typedContent()
    }
    
    let background = {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 180, height: 100))
        background.layer.cornerRadius = 6
        background.layer.shadowOpacity = 0.6
        background.layer.shadowOffset = CGSize(width: 6, height: 6)
        return background
    }()
    
    let name = {
        let name = UILabel(frame: CGRect(x: 16, y: 8, width: 100, height: 24))
        name.font = .systemFont(ofSize: 17, weight: .semibold)
        name.textColor = .white
        return name
    }()
    
    let type = {
        let type = UILabel(frame: CGRect(x: 16, y: 32, width: 80, height: 24))
        type.textAlignment = .center
        type.font = .systemFont(ofSize: 15, weight: .bold)
        type.textColor = .white
        return type
    }()
    
    let typeBackground = {
        let typeBackground = UIView(frame: CGRect(x: 16, y: 32, width: 80, height: 24))
        typeBackground.layer.cornerRadius = 12
        typeBackground.backgroundColor = .white.withAlphaComponent(0.25)
        return typeBackground
    }()
    
    let image = UIImageView(frame: CGRect(x: 108, y: 32, width: 64, height: 64))
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.contentView.addSubview(self.background)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.typeBackground)
        self.contentView.addSubview(self.type)
        self.contentView.addSubview(self.image)
    }
    
    override func prepareForReuse() 
    {
        self.background.backgroundColor = .clear
        self.name.text = ""
        self.type.text = ""
        self.image.image = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pokemon: Pokemon)
    {
        self.name.text = pokemon.name.capitalized
        self.background.backgroundColor = UIColor(pokemon.type.color)
        self.type.text = pokemon.type.rawValue
        PokemonService.shared.image(for: pokemon).addObserver(self).loadIfNeeded()
    }
}

#Preview {
    let cell = PokedexCell()
    cell.configure(with: .bulbasaur)
    
    let s = UIStackView(arrangedSubviews: [cell])
    s.alignment = .center
    let k = UIStackView(arrangedSubviews: [s])
    k.axis = .vertical
    k.alignment = .center
    return k
}
