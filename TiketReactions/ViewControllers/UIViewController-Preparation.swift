//
//  UIViewController-Preparation.swift
//  TiketSignal
//
//  Created by Firas Rafislam on 16/01/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import ObjectiveC
import UIKit
import Prelude

private func swizzle(_ vc: UIViewController.Type) {
    
    [
        (#selector(vc.viewDidLoad), #selector(vc.ck_viewDidLoad)),
        (#selector(vc.viewWillAppear(_:)), #selector(vc.ck_viewWillAppear(_:))),
        (#selector(vc.traitCollectionDidChange(_:)), #selector(vc.ck_traitCollectionDidChange(_:))),
        ].forEach { original, swizzled in
            
            let originalMethod = class_getInstanceMethod(vc, original)
            let swizzledMethod = class_getInstanceMethod(vc, swizzled)
            
            let didAddViewDidLoadMethod = class_addMethod(vc,
                                                          original,
                                                          method_getImplementation(swizzledMethod!),
                                                          method_getTypeEncoding(swizzledMethod!))
            
            if didAddViewDidLoadMethod {
                class_replaceMethod(vc,
                                    swizzled,
                                    method_getImplementation(originalMethod!),
                                    method_getTypeEncoding(originalMethod!))
            } else {
                method_exchangeImplementations(originalMethod!, swizzledMethod!)
            }
    }
}

private var hasSwizzled = false

extension UIViewController {
    final public class func doBadSwizzleStuff() {
        guard !hasSwizzled else { return }
        
        hasSwizzled = true
        swizzle(self)
    }
    
    @objc internal func ck_viewDidLoad() {
        self.ck_viewDidLoad()
        self.bindViewModel()
    }
    
    @objc internal func ck_viewWillAppear(_ animated: Bool) {
        self.ck_viewWillAppear(animated)
        
        if !self.hasViewAppeared {
            self.bindStyles()
            self.hasViewAppeared = true
        }
    }
    
    /**
     The entry point to bind all view model outputs. Called just before `viewDidLoad`.
     */
    @objc open func bindViewModel() {
    }
    
    /**
     The entry point to bind all styles to UI elements. Called just after `viewDidLoad`.
     */
    @objc open func bindStyles() {
    }
    
    @objc public func ck_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.ck_traitCollectionDidChange(previousTraitCollection)
        self.bindStyles()
    }
    
    private struct AssociatedKeys {
        static var hasViewAppeared = "hasViewAppeared"
    }
    
    // Helper to figure out if the `viewWillAppear` has been called yet
    private var hasViewAppeared: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.hasViewAppeared) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.hasViewAppeared,
                                     newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIViewController {
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}


