//
//  ReminderListViewController.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 12/09/2023.
//

import UIKit

class ReminderListViewController: UICollectionViewController {

    
    /*
     Use implicitly unwrapped optionals only when you know that the optional will have a value.
     Otherwise, you risk triggering a runtime error that immediately terminates the app.
     You’ll initialize the data source in the next step to guarantee that the optional has a value.
     */
    var dataSource: DataSource! // Add a dataSource property that implicitly unwraps a DataSource.
    var reminders: [Reminder] = Reminder.sampleData

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        // Cell registration specifies how to configure the content and appearance of a cell.
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Reminder.ID) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }

        var snapshot = Snapshot()
        snapshot.appendSections([0])
        /*
         var reminderTitles = [String]()
         for reminder in Reminder.sampleData {
             reminderTitles.append(reminder.title)
         }
         snapshot.appendItems(reminderTitles)
         */
        // Same approach in 1 line
        snapshot.appendItems(Reminder.sampleData.map { $0.id })
        dataSource.apply(snapshot) // Applying the snapshot reflects the changes in the user interface.
        collectionView.dataSource = dataSource // Assign the data source to the collection view.
    }

    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}

