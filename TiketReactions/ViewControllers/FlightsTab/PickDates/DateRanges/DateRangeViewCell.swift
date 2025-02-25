//
//  DateRangeViewCell.swift
//  TiketReactions
//
//  Created by Firas Rafislam on 23/02/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import UIKit

class DateRangeViewCell: UICollectionViewCell {
    private let defaultTextColor = UIColor.darkGray
    private let selectedColor = UIColor(red: 66/255.0, green: 150/255.0, blue: 240/255.0, alpha: 1.0)
    private let highlightedColor = UIColor(white: 0.9, alpha: 1.0)
    private let disabledColor = UIColor.lightGray
    
    var date: Date?
    var selectedView: UIView?
    var halfBackgroundView: UIView?
    var roundHighlightView: UIView?
    
    var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initLabel()
    }
    
    func initLabel() {
        label = UILabel(frame: frame)
        label.center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        label.font = UIFont(name: "HelveticaNeue", size: 15.0)
        label.textColor = UIColor.darkGray
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
    }
    
    func reset() {
        self.backgroundColor = UIColor.clear
        label.textColor = defaultTextColor
        label.backgroundColor = UIColor.clear
        if selectedView != nil {
            selectedView?.removeFromSuperview()
            selectedView = nil
        }
        if halfBackgroundView != nil {
            halfBackgroundView?.removeFromSuperview()
            halfBackgroundView = nil
        }
        if roundHighlightView != nil {
            roundHighlightView?.removeFromSuperview()
            roundHighlightView = nil
        }
    }
    
    func select() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        selectedView = UIView(frame: CGRect(x: (width - height) / 2, y: 0, width: height, height: height))
        selectedView?.backgroundColor = .tk_official_green
        selectedView?.layer.cornerRadius = height / 2
        self.addSubview(selectedView!)
        self.sendSubviewToBack(selectedView!)
        
        label.textColor = UIColor.white
    }
    
    func highlightRight() {
        // This is used instead of highlight() when we need to highlight cell with a rounded edge on the left
        let width = self.frame.size.width
        let height = self.frame.size.height
        halfBackgroundView = UIView(frame: CGRect(x: width / 2, y: 0, width: width / 2, height: height))
        halfBackgroundView?.backgroundColor = .tk_official_green
        self.addSubview(halfBackgroundView!)
        self.sendSubviewToBack(halfBackgroundView!)
        
        addRoundHighlightView()
    }
    
    func highlightLeft() {
        // This is used instead of highlight() when we need to highlight the cell with a rounded edge on the right
        let width = self.frame.size.width
        let height = self.frame.size.height
        halfBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: width / 2, height: height))
        halfBackgroundView?.backgroundColor = .tk_official_green
        self.addSubview(halfBackgroundView!)
        self.sendSubviewToBack(halfBackgroundView!)
        
        addRoundHighlightView()
    }
    
    func addRoundHighlightView() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        roundHighlightView = UIView(frame: CGRect(x: (width - height) / 2, y: 0, width: height, height: height))
        roundHighlightView?.backgroundColor = .tk_official_green
        roundHighlightView?.layer.cornerRadius = height / 2
        self.addSubview(roundHighlightView!)
        self.sendSubviewToBack(roundHighlightView!)
    }
    
    func highlight() {
        self.backgroundColor = highlightedColor
    }
    
    func disable() {
        label.textColor = disabledColor
    }
}
