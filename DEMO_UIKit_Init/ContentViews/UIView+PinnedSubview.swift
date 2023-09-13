//
//  UIView+PinnedSubview.swift
//  DEMO_UIKit_Init
//
//  Created by Jonathan Duong on 13/09/2023.
//

import UIKit

extension UIView {
    func addPinnedSubView(_ subview: UIView,
                          height: CGFloat? = nil,
                          insets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                              left: 8,
                                                              bottom: 0,
                                                              right: 8)) {
        addSubview(subview)
        // Disable translatesAutoresizingMaskIntoConstraints to prevent the system from creating automatic constraints for this view.
        subview.translatesAutoresizingMaskIntoConstraints = false
        // Pin the subview to the top of the superview by adding and activating a top anchor constraint.
        subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
        // Add padding to the leading edge of the subview by specifying and activating a leading anchor constraint.
        subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
        // Add padding to the trailing edge of the subview by specifying and activating a trailing anchor constraint.
        subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right).isActive = true
        // Add padding to the bottom of the subview by defining and activating a bottom anchor constraint.
        subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom).isActive = true
        // If the caller explicitly provides a height to the function, constrain the subview to that height.
        if let height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
