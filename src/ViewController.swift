//
//  ViewController.swift
//  Boil Clock
//
//  Created by Katya on 18.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

  @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchTextField.layer.cornerRadius = 15
        searchTextField.clipsToBounds = true
        searchTextField.layer.borderWidth = 0
        searchTextField.layer.borderColor = UIColor.clear.cgColor
        ApiManager.init().getAllCategory()
    }
    

    let products = [ProductType.init(name: "ЯЙЦА", color: Constants.Color.tacao, imageName: "cat_eggs"),
                    ProductType.init(name: "КРУПЫ И КАШИ", color: Constants.Color.perano, imageName: "cat_groats"),
                    ProductType.init(name: "МАКАРОНЫ", color: Constants.Color.rajah, imageName: "cat_pasta"),
                    ProductType.init(name: "МЯСО", color: Constants.Color.tickleMePink, imageName: "cat_meat"),
                    ProductType.init(name: "РЫБА", color: Constants.Color.turquoiseBlue, imageName: "cat_fish"),
                    ProductType.init(name: "ОВОЩИ", color: Constants.Color.feijoa, imageName: "cat_veg"),
                    ProductType.init(name: "МОРЕПРОУКТЫ", color: Constants.Color.mauve, imageName: "cat_seafood"),
                    ProductType.init(name: "ГРИБЫ", color: Constants.Color.downy, imageName: "cat_mashr"),
                    ProductType.init(name: "ДРУГОЕ", color: Constants.Color.lavenderRose, imageName: "cat_other")]
    
    
    let colors = [Constants.Color.tacao, Constants.Color.perano, Constants.Color.rajah,
                  Constants.Color.tickleMePink, Constants.Color.turquoiseBlue, Constants.Color.feijoa,
                  Constants.Color.mauve, Constants.Color.downy, Constants.Color.lavenderRose]
    
    
    @IBAction func tapOnBackground(_ sender: Any)
    {
        self.searchTextField.resignFirstResponder()
    }
    
    
    @IBAction func menuPressed(_ sender: Any)
    {
        self.sideViewController()!.toogleLeftViewController()
    }
}

// MARK: UICollectionView Delegate & DataSource Implementation
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 9
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView.tag == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
            let product          = products[indexPath.row]
            cell.label.text      = product.name
            cell.imageView.image = UIImage.init(named: product.imageName)
            return cell
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CustomCollectionViewCell
        
        let product          = products[indexPath.row]
        cell.label.text      = product.name
        cell.backgroundColor = product.color
        cell.imageView.image = UIImage.init(named: product.imageName)
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView.tag == 1
        {
            return CGSize.init(width: collectionView.frame.width / 3, height: collectionView.frame.height)
        }
        return CGSize.init(width: collectionView.frame.width / 3, height: collectionView.frame.height / 3)
    }
    
}
