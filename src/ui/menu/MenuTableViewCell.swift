//
//  MenuTableViewCell.swift
//  Boil Clock
//
//  Created by Katya on 12.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell
{

    override func layoutSubviews()
    {
        super.layoutSubviews()
        imageView?.frame  = CGRect.init(x: 20, y: 10, width: 20, height: 20)
    }

}
