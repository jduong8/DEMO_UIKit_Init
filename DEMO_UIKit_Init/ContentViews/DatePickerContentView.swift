//
//  DatePickerContentView.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 13/09/2023.
//

import UIKit

class DatePickerContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        var date = Date.now
        
        func makeContentView() -> UIView & UIContentView {
             return DatePickerContentView(self)
        }
    }
    
    let datePicker = UIDatePicker()
    var configuration: UIContentConfiguration
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubView(datePicker)
        datePicker.preferredDatePickerStyle = .inline
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        datePicker.date = configuration.date
    }
}

extension UICollectionViewListCell {
    func datePickerConfiguration() -> DatePickerContentView.Configuration {
        DatePickerContentView.Configuration()
    }
}
