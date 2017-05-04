//
//  DropDownCell.swift
//  Boil Clock
//
//  Created by Katya on 04.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell
{
    let productImage      = UIImageView()
    let activityIndicator = UIActivityIndicatorView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.addSubview(productImage)
        productImage.addSubview(activityIndicator)
    }
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        productImage.frame  = CGRect(x:15,
                                     y:7,
                                     width: frame.height - 14,
                                     height:frame.height - 14)
        
        self.textLabel?.frame = CGRect(x: productImage.frame.maxX + 10,
                                       y:0,
                                       width: frame.width - 44,
                                       height: frame.height)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

}
