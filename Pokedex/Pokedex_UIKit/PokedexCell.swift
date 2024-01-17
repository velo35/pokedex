//
//  PokedexCell.swift
//  Pokedex_UIKit
//
//  Created by Scott Daniel on 1/16/24.
//

import UIKit

class PokedexCell: UICollectionViewCell
{
    override init(frame: CGRect) 
    {
        super.init(frame: frame)
        self.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with: Pokemon?)
    {
        
    }
}

#Preview {
    PokedexCell()
}
