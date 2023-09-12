//
//  ReminderViewController.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 12/09/2023.
//

import UIKit

class ReminderViewController: UICollectionViewController {
    var reminder: Reminder

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
}
