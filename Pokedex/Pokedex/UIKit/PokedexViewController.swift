//
//  ViewController.swift
//  Pokedex_UIKit
//
//  Created by Scott Daniel on 1/16/24.
//

import UIKit

class PokedexViewController: UIViewController
{
    let viewModel = PokedexViewModel.shared
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, PokemonEntry>!
    
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
            cell.configure(with: self.viewModel.pokemonCache[entry])
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, PokemonEntry>(collectionView: collectionView) {
            collectionView, indexPath, entry in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: entry)
        }
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<PokedexSupplementaryView>(elementKind: UICollectionView.elementKindSectionFooter) {
            supplementaryView, kind, indexPath in
        }
        
        self.dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        
        self.view = ScrubbyView(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        self.observeEntries()
        self.observePokemon()
    }
    
    private func observeEntries()
    {
        let _ = withObservationTracking {
            self.viewModel.pokemonEntries
        } onChange: {
            DispatchQueue.main.async {
                self.updateEntries()
                self.observeEntries()
            }
        }
    }
    
    private func observePokemon()
    {
        let _ = withObservationTracking {
            self.viewModel.pokemonCache
        } onChange: {
            DispatchQueue.main.async {
                self.updateCells()
                self.observePokemon()
            }
        }
    }
    
    private func observeAllFetched()
    {
        let _ = withObservationTracking {
            self.viewModel.allFetched
        } onChange: {
            DispatchQueue.main.async {
                self.updateLoadAll()
                self.observeAllFetched()
            }
        }
    }
    
    private func updateEntries()
    {
        var snapshot = NSDiffableDataSourceSnapshot<Int, PokemonEntry>()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel.pokemonEntries)
        self.dataSource.apply(snapshot)
    }
    
    private func updateCells()
    {
        let visibleEntries = self.collectionView.visibleCells.compactMap({ self.collectionView.indexPath(for: $0) }).compactMap{ self.viewModel.pokemonEntries[$0.item] }
        var snapshot = self.dataSource.snapshot()
        snapshot.reconfigureItems(visibleEntries)
        self.dataSource.apply(snapshot)
    }
    
    private func updateLoadAll()
    {
        // TODO
    }
}

class PokedexSupplementaryView: UICollectionReusableView
{
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Load All"
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction { _ in
            PokedexViewModel.shared.fetchAll()
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
