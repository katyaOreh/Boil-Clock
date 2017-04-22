//
//  ProductCategoryViewController.swift
//  Boil Clock
//
//  Created by Katya on 19.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class ProductCategoryViewController: UICollectionViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()

        let backButton = UIBarButtonItem.init(image: UIImage.init(named: "back_btn"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(backBtnTapped))
        
        self.navigationItem.leftBarButtonItem = backButton;

    }
    func backBtnTapped()
    {
        _ = navigationController?.popViewController(animated: true)
    }
    

        public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            return 9
        }
        
        public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
            
            cell.backgroundColor = UIColor.red
            
            return cell
        }
        
        public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize.init(width: collectionView.frame.width / 3, height: collectionView.frame.height / 3)
        }
        
    

}
