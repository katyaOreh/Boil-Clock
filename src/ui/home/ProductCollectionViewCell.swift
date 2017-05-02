//
//  ProductCollectionViewCell.swift
//  Boil Clock
//
//  Created by Katya on 21.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    open override func prepareForReuse()
    {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

}
