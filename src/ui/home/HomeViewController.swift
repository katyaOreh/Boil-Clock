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

class HomeViewController: UIViewController, UITextFieldDelegate,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    public let dropdown          = DropDown()
    private var categories       = [ProductCategory]()
    private var favoriteProducts = [Product]()
    private var products         = [Product]()
    
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
        
        view.addSubview(dropdown)
        
        dropdown.addSubview(dropdown.table)
        
    
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
            self.categories       = categories.sorted(by: { $0.id < $1.id})
            self.products         = products
            self.favoriteProducts = products.filter {$0.isFavorite == true}
            self.categoryCollectionView.reloadData()
            self.productsCollectionView.reloadData()
            SVProgressHUD.dismiss()
        }) {
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.favoriteProducts = products.filter {$0.isFavorite == true}
        self.productsCollectionView.reloadData()
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
            
            if let indexPath = categoryCollectionView?.indexPath(for: sender as! CustomCollectionViewCell)
            {
                let productsArray      = products.filter { $0.category?.id == Int16(indexPath.row)}
                destinationVC.title    =  categories[indexPath.row].title
                destinationVC.products = productsArray
            }
        }
        else if segue.identifier == "productDetails"
        {
            let destinationVC = segue.destination as! ProductPageViewController
            if let indexPath = productsCollectionView?.indexPath(for: sender as! ProductCollectionViewCell)
            {
                destinationVC.product = favoriteProducts[indexPath.row]
            }
        }
    }
    
    // MARK: UICollectionView Delegate & DataSource Implementation
  
        public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
            return  collectionView.tag == 1 ? favoriteProducts.count : categories.count
        }
        
        public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
            
            if collectionView.tag == 1
            {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
                let product          = favoriteProducts[indexPath.row]
                cell.label.text      = product.title
                cell.imageView.af_setImage(withURL:URL.init(string: product.image_url!)!, placeholderImage: nil, filter: nil, imageTransition: .noTransition, completion: { (response) -> Void in
                    cell.activityIndicator.stopAnimating()
                })
                return cell
            }
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CustomCollectionViewCell
            
            let category          = categories[indexPath.row]
            cell.label.text       = category.title
            cell.backgroundColor  = hexStringToUIColor(hex: category.color!)
            cell.tag              = Int(category.type)
            if let name = category.image_name
            {
                cell.imageView.image = UIImage.init(named: name)
            }
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            if collectionView.tag == 1
            {
                return CGSize.init(width: collectionView.frame.width / 4, height: collectionView.frame.height)
            }
            return CGSize.init(width: collectionView.frame.width / 3, height: collectionView.frame.height / 3)
        }
        
        public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
        {
            if (collectionView.tag == 2)
            {
                let cell = collectionView.cellForItem(at: indexPath)
                performSegue(withIdentifier: "productsList", sender: cell)
            }else{
                let cell = collectionView.cellForItem(at: indexPath)
                performSegue(withIdentifier: "productDetails", sender: cell)
            }
            
        }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let str = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        
        dropdown.substring = str
        dropdown.items =  str.characters.count == 0 ? [] : getProductForLetter(lets: str)
        
        dropdown.frame = CGRect.init(x: textField.frame.origin.x,
                                     y: textField.frame.maxY + 10,
                                     width: textField.frame.width ,
                                     height: 100)
        
        dropdown.table.reloadData()
        return  true
    }
    
    
    func getProductForLetter(lets :String) -> [Product]
    {
        let mac = products.filter{$0.title!.lowercased().contains(lets.lowercased())}
        return mac
    }
}


