//
//  BasicCollectionViewCell.swift
//  BasicCollectionView
//
//  Created by Nazrin Sultanlı on 18.02.25.
//

//import UIKit
//
//class BasicCollectionViewCell: UICollectionViewCell {
//    
//    @IBOutlet weak var label: UILabel!
//}

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {
    let label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = .black
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
