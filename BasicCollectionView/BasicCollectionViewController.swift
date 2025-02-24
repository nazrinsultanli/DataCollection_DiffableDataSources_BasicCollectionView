//
//  BasicCollectionViewController.swift
//  BasicCollectionView
//
//  Created by Nazrin Sultanlı on 18.02.25.
//

import UIKit

enum Section: CaseIterable {
    case main
}

private let reuseIdentifier = "BasicCell"
private let items = [
    "Alabama", "Alaska", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"
]
var filteredItems: [String] = items

class BasicCollectionViewController: UICollectionViewController, UISearchResultsUpdating {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    var filteredItemsSnapshot: NSDiffableDataSourceSnapshot<Section, String> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(filteredItems)
        
        return snapshot
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController()
        
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        createDataSource()
        collectionView.setCollectionViewLayout(generateAutoLayout(), animated: false)
        
        
        
    }

    func createDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<BasicCollectionViewCell, String> { cell, indexpath, itemIdentifier in
            cell.label.text = itemIdentifier
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier  -> BasicCollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
        dataSource.apply(filteredItemsSnapshot)
    }
    
    private func generateAutoLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let spacing: CGFloat = 10
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(70.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       repeatingSubitem: item,
                                                       count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing,
                                                      leading: spacing,
                                                      bottom: 0,
                                                      trailing: spacing)
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text,
           searchString.isEmpty == false {
            filteredItems = items.filter{ (item) -> Bool in
                item.localizedCaseInsensitiveContains(searchString)
            }
        } else{
            filteredItems = items
        }
        dataSource.apply(filteredItemsSnapshot, animatingDifferences: true)
    }
    
}


