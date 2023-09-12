//
//  ReminderListViewController.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 12/09/2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {
    // Type aliases are helpful for referring to an existing type with a name that’s more expressive.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    
    /*
     Use implicitly unwrapped optionals only when you know that the optional will have a value.
     Otherwise, you risk triggering a runtime error that immediately terminates the app.
     You’ll initialize the data source in the next step to guarantee that the optional has a value.
     */
    var dataSource: DataSource! // Add a dataSource property that implicitly unwraps a DataSource.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        // Cell registration specifies how to configure the content and appearance of a cell.
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item] // Retrieve the reminder corresponding to the item.
            /// defaultContentConfiguration() creates a content configuration with the predefined system style.
            var contentConfiguration = cell.defaultContentConfiguration() // Retrieve the cell’s default content configuration.
            contentConfiguration.text = reminder.title // Assign reminder.title to the content configuration text.
            cell.contentConfiguration = contentConfiguration // Assign the content configuration to the cell.
        }
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

