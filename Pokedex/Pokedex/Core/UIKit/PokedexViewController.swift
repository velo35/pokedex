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
    
    typealias SelectedCallback = (PokemonEntry) -> Void
    var selectedCallback: SelectedCallback
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Int, PokemonEntry>!
    
    init(selectedCallback: @escaping SelectedCallback)
    {
        self.selectedCallback = selectedCallback
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() 
    {        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(180),
                                              heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        group.interItemSpacing = .fixed(16)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.delegate = self
        
        let cellRegistration = UICollectionView.CellRegistration<PokedexCell, PokemonEntry>() { cell, indexPath, entry in
            if let pokemon = self.viewModel.pokemonCache[entry] {
                cell.configure(with: pokemon)
            }
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Int, PokemonEntry>(collectionView: self.collectionView) {
            collectionView, indexPath, entry in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: entry)
        }
        
        self.collectionView.prefetchDataSource = self
        
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<PokedexSupplementaryView>(elementKind: UICollectionView.elementKindSectionFooter) {
            supplementaryView, kind, indexPath in
        }
        
        self.dataSource.supplementaryViewProvider = {
            collectionView, kind, indexPath in
            collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        
        self.collectionView.showsVerticalScrollIndicator = false
        self.view = ScrubbyView(self.collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) 
    {
        self.observeEntries()
        self.observePokemon()
        self.updateEntries()
        self.updateCells()
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

extension PokedexViewController: UICollectionViewDataSourcePrefetching
{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) 
    {
        for indexPath in indexPaths {
            let entry = self.viewModel.pokemonEntries[indexPath.item]
            if let pokemon = self.viewModel.pokemonCache[entry] {
                PokemonService.shared.image(for: pokemon).loadIfNeeded()
            }
        }
    }
}

extension PokedexViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    {
        let entry = self.viewModel.pokemonEntries[indexPath.item]
        self.selectedCallback(entry)
        return false
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
