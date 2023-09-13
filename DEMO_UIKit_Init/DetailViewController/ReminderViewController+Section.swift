//
//  ReminderViewController+Section.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 13/09/2023.
//

import Foundation

extension ReminderViewController {
    enum Section: Int, Hashable {
        case view
        case title
        case date
        case notes

        var name: String {
            switch self {
            case .view:
                return ""
            case .title:
                return NSLocalizedString("Title", comment: "Title section name")
            case .date:
                return NSLocalizedString("Date", comment: "Date section name")
            case .notes:
                return NSLocalizedString("Notes", comment: "Title section name")
            }
        }
    }
}
