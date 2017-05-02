//
//  CustomCollectionViewCell.swift
//  Boil Clock
//
//  Created by Katya on 15.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    
    open override func prepareForReuse()
    {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        self.clipsToBounds = true
    }

}
