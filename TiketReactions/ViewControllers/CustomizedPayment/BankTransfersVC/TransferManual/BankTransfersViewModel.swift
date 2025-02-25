//
//  BankTransfersViewModel.swift
//  TiketReactions
//
//  Created by Firas Rafislam on 22/06/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import Prelude
import ReactiveSwift
import Result
import TiketKitModels

public protocol BankTransfersViewModelInputs {
    func doneButtonItemTapped()
    func dismissTransfers(_ confirmed: Bool)
    func didSelectVirtual(payment: VirtualAccountPayment)
    func viewDidLoad()
}

public protocol BankTransfersViewModelOutputs {
    var doneEnabled: Signal<Bool, NoError> { get }
    var banks: Signal<BankTransferPaymentEnvelope, NoError> { get }
    var banksAreAnimating: Signal<Bool, NoError> { get }
    var confirmTransfers: Signal<(), NoError> { get }
    var transferNotAvailable: Signal<String, NoError> { get }
    var selectedPayment: Signal<URL, NoError> { get }
    var dismissToChecked: Signal<(), NoError> { get }
}

public protocol BankTransfersViewModelType {
    var inputs: BankTransfersViewModelInputs { get }
    var outputs: BankTransfersViewModelOutputs { get }
}

public final class BankTransfersViewModel: BankTransfersViewModelType, BankTransfersViewModelInputs, BankTransfersViewModelOutputs {
    
    public init() {
        let banksAreLoading = MutableProperty(false)
        
        /*
        let vaTransferEvent = self.viewDidLoadProperty.signal.switchMap { _ in
            AppEnvironment.current.apiService.virtualAccountTransfer().on(started: { banksAreLoading.value = true }, terminated: { banksAreLoading.value = false }).materialize()
        }
        */
        
        let banksTransferEvent = self.viewDidLoadProperty.signal.switchMap { _ in
            AppEnvironment.current.apiService.bankTransferRequest().on(started: { banksAreLoading.value = true }, terminated: { banksAreLoading.value = false }).materialize()
        }
        
        self.doneEnabled = banksAreLoading.signal
        
        // bankTransferEvent.values()
        
        self.banks = banksTransferEvent.values()
        self.banksAreAnimating = banksAreLoading.signal
        
        // bankTransferEvent.errors().map { _ in Localizations.TransfernotavailableNotice }
        
        self.transferNotAvailable = banksTransferEvent.errors().map { _ in Localizations.TransfernotavailableNotice }
        
        self.selectedPayment = .empty
        
        
        self.confirmTransfers = self.doneItemTappedProperty.signal
        self.dismissToChecked = self.dismissTransferConfirmedProperty.signal.filter(isTrue).ignoreValues()
    }
    
    fileprivate let configBanksProperty = MutableProperty<[BankTransferPaymentEnvelope.Bank]?>(nil)
    public func configureWith(_ banks: [BankTransferPaymentEnvelope.Bank]) {
        self.configBanksProperty.value = banks
    }
    
    fileprivate let dismissTransferConfirmedProperty = MutableProperty(false)
    public func dismissTransfers(_ confirmed: Bool) {
        self.dismissTransferConfirmedProperty.value = confirmed
    }
    
    fileprivate let selectedVirtualPaymentProperty = MutableProperty<VirtualAccountPayment?>(nil)
    public func didSelectVirtual(payment: VirtualAccountPayment) {
        self.selectedVirtualPaymentProperty.value = payment
    }
    
    fileprivate let doneItemTappedProperty = MutableProperty(())
    public func doneButtonItemTapped() {
        self.doneItemTappedProperty.value = ()
    }
    
    fileprivate let viewDidLoadProperty = MutableProperty(())
    public func viewDidLoad() {
        self.viewDidLoadProperty.value = ()
    }
    
    public let doneEnabled: Signal<Bool, NoError>
    public let banks: Signal<BankTransferPaymentEnvelope, NoError>
    public let banksAreAnimating: Signal<Bool, NoError>
    public let confirmTransfers: Signal<(), NoError>
    public let transferNotAvailable: Signal<String, NoError>
    public let selectedPayment: Signal<URL, NoError>
    public let dismissToChecked: Signal<(), NoError>
    
    public var inputs: BankTransfersViewModelInputs { return self }
    public var outputs: BankTransfersViewModelOutputs { return self }
}
