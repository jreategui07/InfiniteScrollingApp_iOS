//
//  AnimalCell.swift
//  InfiniteScrolling
//
//  Created by Jonathan Reátegui on 2025-01-08.
//

import UIKit

class AnimalCell: UITableViewCell {
    
    static let identifier = "AnimalCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
