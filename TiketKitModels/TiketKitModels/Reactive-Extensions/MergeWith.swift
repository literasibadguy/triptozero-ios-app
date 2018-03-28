import ReactiveSwift

public extension SignalProtocol {
    
    public func mergeWith(_ other: Signal<Value, Error>) -> Signal<Value, Error> {
        return Signal.merge([self.signal, other])
    }
}

public extension SignalProducerProtocol {
    
    public func mergeWith(_ other: SignalProducer<Value, Error>) -> SignalProducer<Value, Error> {
        return SignalProducer<SignalProducer<Value, Error>, Error>([self.producer, other]).flatten(.merge)
    }
}

