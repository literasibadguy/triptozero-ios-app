//
//  TabBarItemStyles.swift
//  TiketComponents
//
//  Created by Firas Rafislam on 08/02/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import Prelude
import UIKit

public let tabBarSelectedColor = UIColor.tk_official_green
public let tabBarTintColor = UIColor.white

private let paddingY: CGFloat = 4.0

private let baseTabBarItemStyle = UITabBarItem.lens.title .~ nil

public func flightTabBarItemStyle() -> (UITabBarItem) -> UITabBarItem {
    return baseTabBarItemStyle
        <> UITabBarItem.lens.title %~ { _ in "Trip" }
        <> UITabBarItem.lens.image .~ image(named: "flight-tabbar-icon")
        <> UITabBarItem.lens.selectedImage .~ image(named: "flight-tabbar-icon-selected")
        <> UITabBarItem.lens.accessibilityLabel .~ "Flight"
}

public func hotelTabBarItemStyle() -> (UITabBarItem) -> UITabBarItem {
    return baseTabBarItemStyle
        <> UITabBarItem.lens.title %~ { _ in "Hotel" }
        <> UITabBarItem.lens.image .~ image(named: "hotel-tabbar-icon")
        <> UITabBarItem.lens.selectedImage .~ image(named: "hotel-tabbar-icon-selected")
        <> UITabBarItem.lens.accessibilityLabel .~ "Hotel"
}

public func orderTabBarItemStyle() -> (UITabBarItem) -> UITabBarItem {
    return baseTabBarItemStyle
        <> UITabBarItem.lens.title %~ { _ in "Order" }
        <> UITabBarItem.lens.image .~ image(named: "order-tabbar-icon")
        <> UITabBarItem.lens.selectedImage .~ image(named: "order-tabbar-icon-selected")
        <> UITabBarItem.lens.accessibilityLabel .~ "Order"
}

public func issueTabBarItemStyle() -> (UITabBarItem) -> UITabBarItem {
    return baseTabBarItemStyle
        <> UITabBarItem.lens.title %~ { _ in "Lounge" }
        <> UITabBarItem.lens.image .~ image(named: "lounge-tabbar-icon")
        <> UITabBarItem.lens.selectedImage .~ image(named: "lounge-tabbar-icon-selected")
        <> UITabBarItem.lens.accessibilityLabel .~ "Order"
}

public func aboutTabBarItemStyle() -> (UITabBarItem) -> UITabBarItem {
    return baseTabBarItemStyle
        <> UITabBarItem.lens.title %~ { _ in "About" }
        <> UITabBarItem.lens.image .~ image(named: "about-tabbar-icon")
        <> UITabBarItem.lens.selectedImage .~ image(named: "about-tabbar-icon-selected")
        <> UITabBarItem.lens.accessibilityLabel .~ "About"
}
