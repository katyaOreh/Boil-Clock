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

class HomeViewController: UIViewController, UITextFieldDelegate,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DropDownDelegate
{
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    
    public let dropdown          = DropDown()
    private var categories       = [ProductCategory]()
    private var favoriteProducts = [Product]()
    private var products         = [Product]()
    
    var searchProducts : [Product]?
    
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
        dropdown.delegate = self
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        categories = CoreDataManager.sharedInstance.getAllCategories()!
        categoryCollectionView.reloadData()
        
        products = CoreDataManager.sharedInstance.getAllProducts()!
        productsCollectionView.reloadData()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(HomeViewController.leftSwiped))
        
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self,
                                                 action: #selector(HomeViewController.rightSwiped))
        
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        
        swipeLeft.cancelsTouchesInView = false
        swipeRight.cancelsTouchesInView = false
    
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        favoriteProducts = products.filter {$0.isFavorite == true}
        productsCollectionView.reloadData()
    }
    
    
    @IBAction func tapOnBackground(_ sender: Any)
    {
        searchTextField.resignFirstResponder()
    }
    
    
    @IBAction func menuPressed(_ sender: Any)
    {
       sideViewController()!.toogleLeftViewController()
        searchTextField.resignFirstResponder()
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
            
            if sender is Product
            {
                 destinationVC.product = sender as? Product
                return
            }
        }
    }
    
    
    // MARK: - UICollectionView Delegate & DataSource Implementation
  
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
                performSegue(withIdentifier: "productDetails", sender: favoriteProducts[indexPath.row])
            }
            
        }
    
    func leftSwiped()
    {
        sideViewController()!.hideLeftViewController()
    }
    
    func rightSwiped()
    {
        sideViewController()!.toogleLeftViewController()
        searchTextField.resignFirstResponder()
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
        dropdown.alpha = 1
        searchProducts = products.filter{$0.title!.lowercased().contains(lets.lowercased())}
        return  searchProducts!
    }
    
    // MARK: - DropDownDelegate
    
    func didSelectItem(dropDown: DropDown, at index: Int)
    {
        if searchProducts?.isEmpty == true
        {
            return
        }
        performSegue(withIdentifier: "productDetails", sender: (searchProducts?[index])!)
    }
    
    func show(dropDown: DropDown)
    {

    }
    
    
    func hide(dropDown: DropDown)
    {
        dropdown.alpha = 0
        searchTextField.resignFirstResponder()
    }
}


