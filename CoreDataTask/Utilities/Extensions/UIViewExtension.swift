//
//  UIViewExtension.swift
//  CoreDataTask
//
//  Created by Mohammed mohsen on 21/12/2020.
//

import UIKit

extension UIView {

    func addSubviews(views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
