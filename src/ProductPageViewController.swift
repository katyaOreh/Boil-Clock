//
//  ProductPageViewController.swift
//  Boil Clock
//
//  Created by Katya on 19.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class ProductPageViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let backButton = UIBarButtonItem.init(image: UIImage.init(named: "back_btn"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(backBtnTapped))
        
        let starButton = UIBarButtonItem.init(image: UIImage.init(named: "fav_add"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(backBtnTapped))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem = starButton
    }
    
    func backBtnTapped()
    {
        _ = navigationController?.popViewController(animated: true)
    }


    @IBAction func starTapped(_ sender: Any)
    {
        print("ffffffff");
    }
}
