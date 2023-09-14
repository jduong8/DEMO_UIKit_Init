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
    var workingReminder: Reminder
    private var dataSource: DataSource!

    init(reminder: Reminder) {
        self.reminder = reminder
        self.workingReminder = reminder
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
        if #available(iOS 16, *) {
            navigationItem.style = .navigator
        }
        navigationItem.title = NSLocalizedString(reminder.title, comment: "Reminder view controller title")
        navigationItem.rightBarButtonItem = editButtonItem

        self.updateSnapshotForViewing()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            self.prepareForEditing()
        } else {
            self.prepareForViewing()
        }
    }

    func cellRegistrationHandler(
        cell: UICollectionViewListCell,
        indexPath: IndexPath,
        row: Row
    ) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = self.headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = self.defaultConfiguration(for: cell, at: row)
        case (.title, .editableText(let title)):
            cell.contentConfiguration = self.titleConfiguration(for: cell, with: title)
        case (.date, .editableDate(let date)):
            cell.contentConfiguration = self.dateConfiguration(for: cell, with: date)
        case (.notes, .editableText(let notes)):
            cell.contentConfiguration = self.notesConfiguration(for: cell, with: notes)
        default:
            fatalError("Unexpected combination of section and row.")
        }
        cell.tintColor = .todayPrimaryTint
    }
    
    private func prepareForEditing() {
        self.updateSnapshotForEditing()
    }

    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.title, .date, .notes])
        snapshot.appendItems([.header(Section.title.name),
                              .editableText(reminder.title)],
                             toSection: .title)
        snapshot.appendItems([.header(Section.date.name), .editableDate(reminder.dueDate)], toSection: .date)
        snapshot.appendItems([.header(Section.notes.name), .editableText(reminder.notes)], toSection: .notes)
        dataSource.apply(snapshot)
    }
    
    private func prepareForViewing() {
        if workingReminder != reminder {
            reminder = workingReminder
        }
        self.updateSnapshotForViewing()
    }

    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems(
            [Row.title, Row.date, Row.time, Row.notes],
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
