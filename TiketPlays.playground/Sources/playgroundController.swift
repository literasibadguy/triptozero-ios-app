import UIKit


public enum Device {
    case phone3_5inch
    case phone4inch
    case phone4_7inch
    case phone5_5inch
    case pad
    case pad12_9inch
}

public enum Orientation {
    case portrait
    case landscape
}

public func playgroundControllers(device: Device = .phone4_7inch,
                                  orientation: Orientation = .portrait,
                                  child: UIViewController = UIViewController(),
                                  additionalTraits: UITraitCollection = .init())
    -> (parent: UIViewController, child: UIViewController) {
        
        let parent = UIViewController()
        parent.addChildViewController(child)
        parent.view.addSubview(child.view)
        
        child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let traits: UITraitCollection
        switch (device, orientation) {
        case (.phone3_5inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 320, height: 480)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone3_5inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 480, height: 320)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 320, height: 568)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 568, height: 320)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4_7inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 375, height: 667)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone4_7inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 667, height: 375)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone5_5inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 414, height: 736)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .compact),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.phone5_5inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 736, height: 414)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .compact),
                .init(userInterfaceIdiom: .phone)
                ])
        case (.pad, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 768, height: 1024)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        case (.pad, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 1024, height: 768)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        case (.pad12_9inch, .portrait):
            parent.view.frame = .init(x: 0, y: 0, width: 1024, height: 1366)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        case (.pad12_9inch, .landscape):
            parent.view.frame = .init(x: 0, y: 0, width: 1366, height: 1024)
            traits = .init(traitsFrom: [
                .init(horizontalSizeClass: .regular),
                .init(verticalSizeClass: .regular),
                .init(userInterfaceIdiom: .pad)
                ])
        }
        
        child.view.frame = parent.view.frame
        parent.preferredContentSize = parent.view.frame.size
        parent.view.backgroundColor = .white
        child.view.backgroundColor = .white
        
        let allTraits = UITraitCollection.init(traitsFrom: [traits, additionalTraits])
        parent.setOverrideTraitCollection(allTraits, forChildViewController: child)
        
        return (parent, child)
}


