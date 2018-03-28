import ReactiveSwift
import Result
import UIKit

private enum Associations {
    fileprivate static var minimumValue = 0
    fileprivate static var maximumValue = 1
}

public extension Rac where Object: UIStepper {
    public var minimumValue: Signal<Double, NoError> {
        nonmutating set {
            let prop: MutableProperty<Double> = lazyMutableProperty(
                object,
                key: &Associations.minimumValue,
                setter: { [weak object] in object?.minimumValue = $0 },
                getter: { [weak object] in object?.minimumValue ?? Double(0) })
            
            prop <~ newValue.observe(on: UIScheduler())
        }
        
        get {
            return .empty
        }
    }
    
    public var maximumValue: Signal<Double, NoError> {
        nonmutating set {
            let prop: MutableProperty<Double> = lazyMutableProperty(
                object,
                key: &Associations.maximumValue,
                setter: { [weak object] in object?.maximumValue = $0 },
                getter: { [weak object] in object?.maximumValue ?? Double(0) })
            
            prop <~ newValue.observe(on: UIScheduler())
        }
        
        get {
            return .empty
        }
    }
}
