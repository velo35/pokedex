//
//  ViewController.swift
//  Pokedex_UIKit
//
//  Created by Scott Daniel on 1/16/24.
//

import UIKit

class PokedexViewController: UIViewController
{
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, PokemonEntry>!
    var pokemonCache = [PokemonEntry: Pokemon]()
    var entryIndexPath = [PokemonEntry: IndexPath]()
    
    override func loadView() 
    {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 180, height: 100)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 16
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        flowLayout.footerReferenceSize = CGSize(width: 0, height: 44)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.collectionView = collectionView
        
        let cellRegistration = UICollectionView.CellRegistration<PokedexCell, PokemonEntry>() {
            [unowned self]
            cell, indexPath, entry in
            entryIndexPath[entry] = indexPath
            if let pokemon = self.pokemonCache[entry] {
                cell.configure(with: pokemon)
            }
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, PokemonEntry>(collectionView: collectionView) {
            collectionView, indexPath, entry in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: entry)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<PokedexSupplementaryView>(elementKind: UICollectionView.elementKindSectionFooter) {
            supplementaryView, kind, indexPath in
            supplementaryView.callback = {
                print("hey!")
            }
        }
        
        self.dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        
        self.view = ScrubbyView(collectionView)
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
                self.pokemonCache[entry] = resource.typedContent()
                if let indexPath = self.entryIndexPath[entry],
                    let pokemon = self.pokemonCache[entry],
                    let cell = self.collectionView.cellForItem(at: indexPath) as? PokedexCell {
                    cell.configure(with: pokemon)
                }
            }).loadIfNeeded()
        }
    }
}

class PokedexSupplementaryView: UICollectionReusableView
{
    var callback: () -> Void = {}
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Load More"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction { [unowned self] _ in
            self.callback()
        })
        
        self.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
