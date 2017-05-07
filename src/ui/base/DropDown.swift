//
//  DropDown.swift
//  Boil Clock
//
//  Created by Katya on 04.05.17.
//  Copyright © 2017 anka. All rights reserved.
//

import UIKit

protocol DropDownDelegate: class
{
    func didSelectItem(dropDown: DropDown, at index: Int)
    func show(dropDown: DropDown)
    func hide(dropDown: DropDown)
    
}

class DropDown: UIView
{
    var delegate: DropDownDelegate!
    
    var table = UITableView()
    
    var substring = ""
    
    fileprivate var titleFontSize1 : CGFloat = 14.0
    
    @IBInspectable
    var itemTextColor : UIColor
    {
        set
        {
            itemFontColor = newValue
        }
        get
        {
            return itemFontColor
        }
    }
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.layer.cornerRadius = 4
        self.layer.borderColor  = UIColor.clear.cgColor
        self.layer.borderWidth  = 1
        self.clipsToBounds      = true
        
        table.dataSource    = self
        table.delegate      = self
        table.frame         = self.bounds
        table.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var itemFontColor = UIColor.black
    fileprivate var itemHeight1 = 50
    
    
    fileprivate var itemFontSize : CGFloat = 14.0
    
    var itemFont = UIFont.systemFont(ofSize: 14)
    
    var items = [Product]()
    fileprivate var selectedIndex = -1
    
    var isCollapsed = true
    
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.table.frame = CGRect(x: 0,
                                  y: 0,
                                  width: Int(self.frame.width),
                                  height:  items.count > 5 ?  5 * itemHeight1 : items.count * itemHeight1 )
        
        self.frame = CGRect(x: Int(self.frame.origin.x),
                            y: Int(self.frame.origin.y),
                            width: Int(self.frame.width),
                            height: Int(self.table.frame.height))
        
    }
    
    
    // Default tableview frame
    var tableFrame = CGRect.zero
    
    func didTapBackground(gesture: UIGestureRecognizer)
    {
        isCollapsed = true
        collapseTableView()
        
    }
    
    func collapseTableView()
    {
        
        if isCollapsed
        {
            // removing tableview from rootview
            
            var rootView = self.superview
            
            while rootView?.superview != nil
            {
                rootView = rootView?.superview
            }
            
            rootView?.viewWithTag(99121)?.removeFromSuperview()
            self.superview?.viewWithTag(99121)?.removeFromSuperview()
            if delegate != nil {
                delegate.hide(dropDown: self)
            }
        }
    }
}


extension DropDown : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? DropDownCell
        if (cell == nil)
        {
            cell = DropDownCell(style: .default, reuseIdentifier: "cell")
        }
        
        let str = NSMutableAttributedString.init(string: items[indexPath.row].title!,
                                                 attributes:  [NSFontAttributeName : UIFont(descriptor: itemFont.fontDescriptor, size: itemFontSize)
            ])
        
        let rg  = items[indexPath.row].title?.lowercased().range(of: substring.lowercased())
        
        if rg == nil
        {
            return cell!
        }
        
        
        let rangeStartIndex = rg!.lowerBound
        let rangeEndIndex  = rg!.upperBound
        
        let start = items[indexPath.row].title?.distance(from: (items[indexPath.row].title?.startIndex)!, to: rangeStartIndex)
        
        let length = items[indexPath.row].title?.distance(from: rangeStartIndex, to: rangeEndIndex)
        
        let nsRange = NSMakeRange(start!, length!)
        
        
        str.setAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 14)],
                          range: nsRange)
        
        
        cell?.textLabel?.attributedText = str
        
        cell?.productImage.af_setImage(withURL:URL.init(string: items[indexPath.row].image_url!)!, placeholderImage: nil, filter: nil, imageTransition: .noTransition, completion: { (response) -> Void in
            cell?.activityIndicator.stopAnimating()
        })
        
        
        
        cell?.backgroundColor = UIColor.clear
        
        cell?.tintColor = self.tintColor
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(itemHeight1)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedIndex = indexPath.row
        isCollapsed = true
        collapseTableView()
        if delegate != nil
        {
            delegate.didSelectItem(dropDown: self, at: selectedIndex)
        }
    }
}
