//
//  ViewController.swift
//  Pokedex_UIKit
//
//  Created by Scott Daniel on 1/16/24.
//

import UIKit

class ViewController: UICollectionViewController 
{
    var dataSource: UICollectionViewDiffableDataSource<Int, PokemonEntry>!
    
    init()
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 180, height: 100)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var entryIndexPath = [PokemonEntry: IndexPath]()
    
    override func viewDidLoad() 
    {
        super.viewDidLoad()
        
        let cellRegistration = UICollectionView.CellRegistration<PokedexCell, PokemonEntry>() {
            [unowned self]
            cell, indexPath, entry in
            entryIndexPath[entry] = indexPath
            if let pokemon = entry.pokemon {
                cell.configure(with: pokemon)
            }
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, PokemonEntry>(collectionView: self.collectionView) {
            collectionView, indexPath, entry in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: entry)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) 
    {
        
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        print("viewWillAppear")
        PokemonService.shared.pokemonEntries(for: 0..<151).addObserver(owner: self, closure: {
            [unowned self]
            resource, event in
            self.addEntries(resource.typedContent())
        }).loadIfNeeded()
    }
    
    func addEntries(_ entries: [PokemonEntry]?)
    {
        print("addEntries")
        guard let entries else { return }
        var snapshot = NSDiffableDataSourceSnapshot<Int, PokemonEntry>()
        snapshot.appendSections([0])
        snapshot.appendItems(entries)
        self.dataSource.apply(snapshot)
        
        print("entries added!")
        
        for entry in entries {
            PokemonService.shared.pokemon(for: entry).addObserver(owner: self, closure: {
                [unowned self]
                resource, event in
                entry.pokemon = resource.typedContent()
                if let indexPath = self.entryIndexPath[entry], 
                    let pokemon = entry.pokemon,
                    let cell = self.collectionView.cellForItem(at: indexPath) as? PokedexCell {
                    cell.configure(with: pokemon)
                }
            }).loadIfNeeded()
        }
    }
}
