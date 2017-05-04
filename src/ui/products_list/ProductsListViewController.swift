//
//  ProductsListViewController.swift
//  Boil Clock
//
//  Created by Katya on 27.04.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    private var index = 0
    @IBOutlet weak var collectionView: UICollectionView!
    public var products = [Product]()
    {
        didSet
        {
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem.init(image: UIImage.init(named: "back_btn"),
                                              style: .plain,
                                              target: self,
                                              action: #selector(backBtnTapped))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.collectionView?.reloadData()
        
        
        
    }
  
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        debugPrint("ProductsListViewController didReceiveMemoryWarning")
    }

    
    func backBtnTapped()
    {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return  products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
        
        cell.imageView.af_cancelImageRequest()
        
        let product          = products[indexPath.row]
        cell.label.text      = product.title
        cell.activityIndicator.startAnimating()
        
        cell.imageView.af_setImage(withURL:URL.init(string: product.image_url!)!, placeholderImage: nil, filter: nil, imageTransition: .noTransition, completion: { (response) -> Void in
            cell.activityIndicator.stopAnimating()
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath)
        performSegue(withIdentifier: "productDetails", sender: cell)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize.init(width: collectionView.frame.width / 3 , height: collectionView.frame.width / 3)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destinationVC = segue.destination as! ProductPageViewController
        if let indexPath   = collectionView?.indexPath(for: sender as! ProductCollectionViewCell)
        {
            destinationVC.product = products[indexPath.row]
        }
    }
}

