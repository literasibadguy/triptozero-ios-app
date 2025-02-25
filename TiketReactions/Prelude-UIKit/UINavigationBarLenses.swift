//
//  UINavigationBarLenses.swift
//  TiketSignal
//
//  Created by Firas Rafislam on 12/01/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import Prelude
import UIKit

public protocol UINavigationBarProtocol: UIViewProtocol {
    func backgroundImage(for barMetrics: UIBarMetrics) -> UIImage?
    var barTintColor: UIColor? { get set }
    func setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics)
    var shadowImage: UIImage? { get set }
    var titleTextAttributes: [NSAttributedString.Key : Any]? { get set }
    var isTranslucent: Bool { get set }
    var prefersLargeTitles: Bool { get set }
}

extension UINavigationBar: UINavigationBarProtocol {}

public extension LensHolder where Object: UINavigationBarProtocol {
    func backgroundImage(forBarMetrics barMetrics: UIBarMetrics) -> Lens<Object, UIImage?> {
        return Lens(
            view: { view in view.backgroundImage(for: barMetrics) },
            set: { view, set in set.setBackgroundImage(view, for: barMetrics); return set}
        )
    }
    
    var barTintColor: Lens<Object, UIColor?> {
        return Lens(
            view: { $0.barTintColor },
            set: { $1.barTintColor = $0; return $1; }
        )
    }
    
    var shadowImage: Lens<Object, UIImage?> {
        return Lens(
            view: { $0.shadowImage },
            set: { $1.shadowImage = $0; return $1; }
        )
    }
    
    var titleTextAttributes: Lens<Object, [NSAttributedString.Key: Any]> {
        return Lens(
            view: { view in view.titleTextAttributes ?? [:] },
            set: { view, set in set.titleTextAttributes = view; return set; }
        )
    }
    
    var translucent: Lens<Object, Bool> {
        return Lens(
            view: { view in view.isTranslucent },
            set: { view, set in set.isTranslucent = view; return set; }
        )
    }
    
    var prefersLargeTitles: Lens<Object, Bool> {
        return Lens(
            view: { view in view.prefersLargeTitles },
            set: { view, set in set.prefersLargeTitles = view; return set; }
        )
    }
}
