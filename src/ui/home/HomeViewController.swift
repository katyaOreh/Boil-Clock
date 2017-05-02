//
//  HomeViewController.swift
//  Boil Clock
//
//  Created by Katya on 18.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit
import Foundation
import SVProgressHUD

class HomeViewController: UIViewController, UITextViewDelegate
{
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var categories       = [ProductCategory]()
    var productIndex     = 0
    var favoriteProducts = [Product]()
    private var products = [Product]()
    private var selectedCategory = ""
    
    let colors = [Constants.Color.tacao, Constants.Color.perano, Constants.Color.rajah,
                  Constants.Color.tickleMePink, Constants.Color.turquoiseBlue, Constants.Color.feijoa,
                  Constants.Color.mauve, Constants.Color.downy, Constants.Color.lavenderRose]
    
    override func loadView()
    {
        super.loadView()
        searchTextField.layer.cornerRadius = 15
        searchTextField.clipsToBounds      = true
        searchTextField.layer.borderWidth  = 0
        searchTextField.layer.borderColor  = UIColor.clear.cgColor
        
        let leftView                 = UIView.init(frame:(CGRect.init(x: 0, y: 0, width: 15, height: 10)))
        searchTextField.leftViewMode = .always
        searchTextField.leftView     = leftView
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let productCategories : [Dictionary<String, Any>]  =  [["title": "ЯЙЦА", "image_name": "cat_eggs", "type": NSNumber.init(value: 4), "color" : "#f2a482", "id" : Int16(0)],
                                                               ["title": "КРУПЫ И КАШИ", "image_name": "cat_groats", "type":NSNumber.init(value: 6), "color" : "#a0b7f1",  "id" : Int16(1)],
                                                               ["title": "МАКАРОНЫ", "image_name": "cat_pasta", "type":NSNumber.init(value: 7), "color" : "#f4bd75", "id" : Int16(2)],
                                                               ["title" : "МЯСО", "image_name": "cat_meat", "type":NSNumber.init(value: 0), "color" : "#ff89aa",  "id" : Int16(3)],
                                                               ["title" : "РЫБА", "image_name": "cat_fish", "type":NSNumber.init(value: 2), "color" : "#70e0ed", "id" : Int16(4)],
                                                               ["title" : "ОВОЩИ", "image_name": "cat_veg", "type":NSNumber.init(value: 1), "color" : "#b5dd7a", "id" : Int16(5)],
                                                               ["title" : "МОРЕПРОУКТЫ", "image_name": "cat_seafood", "type":NSNumber.init(value: 3), "color" : "#d9a0f1",  "id" : Int16(6)],
                                                               ["title" : "ГРИБЫ", "image_name": "cat_mashr", "type":NSNumber.init(value: 5), "color" : "#7bdea8",  "id" : Int16(7)],
                                                               
                                                               ["title" : "ДРУГОЕ", "image_name": "cat_other", "type":NSNumber.init(value: 8), "color" : "#f794dc",  "id" : Int16(7)]]
        
        
        for dict in productCategories
        {
            CoreDataManager.sharedInstance.updateCategory(dictionary: dict)
        }
        SVProgressHUD.show()
        ApiManager.sharedInstance.getAllCategory(success: { (categories: [ProductCategory], products :[Product] ) in
            self.categories = categories.sorted(by: { $0.id < $1.id})
            self.products   = products
            self.categoryCollectionView.reloadData()
            self.productsCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }) {
            
        }
    }
    
    
    @IBAction func tapOnBackground(_ sender: Any)
    {
        self.searchTextField.resignFirstResponder()
    }
    
    
    @IBAction func menuPressed(_ sender: Any)
    {
        self.sideViewController()!.toogleLeftViewController()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        
        if segue.identifier == "productsList"
        {
            let destinationVC = segue.destination as! ProductsListViewController
            destinationVC.title    = selectedCategory
            destinationVC.products = products.filter {
                $0.category?.type == Int16(productIndex)
            }
        }
        
        //        destinationVC.products = self.products.   filter({($0.title == "1") -> Bool in
        //        })
    }
    
}

// MARK: UICollectionView Delegate & DataSource Implementation
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  collectionView.tag == 1 ? favoriteProducts.count : categories.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        if collectionView.tag == 1
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
            //            let product          = products[indexPath.row]
            //            cell.label.text      = product.name
            //            cell.imageView.image = UIImage.init(named: product.imageName)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CustomCollectionViewCell
        
        let category          = categories[indexPath.row]
        cell.label.text       = category.title
        cell.backgroundColor  = hexStringToUIColor(hex: category.color!)
        
        if let name = category.image_name
        {
            cell.imageView.image = UIImage.init(named: name)
        }
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
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        productIndex = indexPath.row
    }
    
}
