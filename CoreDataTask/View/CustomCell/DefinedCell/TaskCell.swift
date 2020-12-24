//
//  PersonCell.swift
//  CoreDataTutorial
//
//  Created by Mohammed mohsen on 07/12/2020.
//  Copyright © 2020 Mohammed mohsen. All rights reserved.
//

import UIKit


class TaskCell: UITableViewCell {
    
    static let cellId = "taskCell"
    weak var delegate: TaskCellDelegate?
    let favourit: UIButton = {
        let b = UIButton(frame: .init(x: 0, y: 0, width: 50, height: 50))
        b.setImage(UIImage(systemName: "star"), for: .normal)
        return b
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessoryView = favourit
        favourit.addTarget(self , action: #selector(getTapped ), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func getTapped () {
        delegate?.favouriteTapped(self)
    }
    
    
    
}


