//
//  TextFieldContentView.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 13/09/2023.
//

import UIKit

class TextFieldContentView: UIView {
    let textField = UITextField()
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 0, height: 44)
    }
    
    init() {
        super.init(frame: .zero)
        addPinnedSubView(textField,
                         insets: UIEdgeInsets(top: 0,
                                              left: 16,
                                              bottom: 0,
                                              right: 16))
        textField.clearButtonMode = .whileEditing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
