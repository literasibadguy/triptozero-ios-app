//
//  UIWebViewLenses.swift
//  TiketReactions
//
//  Created by Firas Rafislam on 12/04/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

#if os(iOS)
import Prelude
import WebKit

public protocol UIWebViewProtocol: UIViewProtocol {
    var scrollView: UIScrollView { get }
    var suppressesIncrementalRendering: Bool { get set }
}

extension UIWebView: UIWebViewProtocol {}

public extension LensHolder where Object: UIWebViewProtocol {
    var scrollView: Lens<Object, UIScrollView> {
        return Lens(
            view: { $0.scrollView },
            set: { $1 }
        )
    }
    
    var suppressesIncrementalRendering: Lens<Object, Bool> {
        return Lens(
            view: { $0.suppressesIncrementalRendering },
            set: { $1.suppressesIncrementalRendering = $0; return $1 }
        )
    }
}

extension Lens where Whole: UIWebViewProtocol, Part == UIScrollView {
    public var delaysContentTouches: Lens<Whole, Bool> {
        return Whole.lens.scrollView..Part.lens.delaysContentTouches
    }
    
    public var decelerationRate: Lens<Whole, UIScrollView.DecelerationRate> {
        return Whole.lens.scrollView..Part.lens.decelerationRate
    }
}

#endif
