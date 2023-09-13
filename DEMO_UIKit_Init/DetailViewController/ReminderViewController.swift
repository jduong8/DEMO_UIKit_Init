//
//  ReminderViewController.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 12/09/2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>

    var reminder: Reminder
    private var dataSource: DataSource!

    init(reminder: Reminder) {
        self.reminder = reminder
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        // Recall from Class Inheritance and Initialization that a Swift subclass must call one of its superclass’s designated initializers during initialization.
        super.init(collectionViewLayout: listLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("Always initialize ReminderViewController using init(reminder:)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: itemIdentifier
            )
        }
        navigationItem.title = NSLocalizedString(reminder.title, comment: "Reminder view controller title")
        
        self.updateSnapshot()
    }

    func cellRegistrationHandler(
        cell: UICollectionViewListCell,
        indexPath: IndexPath,
        row: Row
    ) {
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = text(for: row)
        contentConfiguration.textProperties.font = UIFont.preferredFont(forTextStyle: row.textStyle)
        contentConfiguration.image = row.image
        cell.contentConfiguration = contentConfiguration
        cell.tintColor = .todayPrimaryTint
    }

    func text(for row: Row) -> String? {
        switch row {
        case .date:
            return reminder.dueDate.dayText
        case .notes:
            return reminder.notes
        case .time:
            return reminder.dueDate.formatted(date: .omitted, time: .shortened)
        case .title:
            return reminder.title
        }
    }

    private func updateSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems(
            [
                Row.title,
                Row.date,
                Row.time,
                Row.notes
            ],
            toSection: .view)
        dataSource.apply(snapshot)
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
}
