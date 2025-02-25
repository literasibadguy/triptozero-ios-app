//
//  IssuedListViewCell.swift
//  TiketReactions
//
//  Created by Firas Rafislam on 16/07/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import Prelude
import ReactiveSwift
import UIKit

public protocol IssuedListCellDelegate: class {
    func deleteOrderButtonTapped(_ cell: IssuedListViewCell, issue: IssuedOrder)
}

public final class IssuedListViewCell: UITableViewCell, ValueCell {
    
    public typealias Value = IssuedOrder
    
    fileprivate let viewModel: IssuedListCellViewModelType = IssuedListCellViewModel()
    
    @IBOutlet fileprivate weak var issueStackView: UIStackView!
//    @IBOutlet fileprivate weak var hotelNameLabel: UILabel!
    @IBOutlet fileprivate weak var issueDateLabel: UILabel!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    @IBOutlet fileprivate weak var separatorView: UIView!
    
    weak var delegate: IssuedListCellDelegate?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public override func bindStyles() {
        super.bindStyles()
        
        _ = self.issueDateLabel
            |> UILabel.lens.textColor .~ .tk_official_green
        
        _ = self.emailLabel
            |> UILabel.lens.textColor .~ .tk_typo_green_grey_600
        
        _ = self.separatorView
            |> UIView.lens.backgroundColor .~ .tk_base_grey_100
    }
    
    public override func bindViewModel() {
        super.bindViewModel()
        
        self.viewModel.outputs.deletedOrder
            .observe(on: UIScheduler())
            .observeValues { [weak self] deleting in
                guard let _self = self else { return }
                print("What should be deleting: \(deleting.orderId)")
                _self.delegate?.deleteOrderButtonTapped(_self, issue: deleting)
        }
    }
    
    public func configureWith(value: IssuedOrder) {
        self.viewModel.inputs.configureWith(value)
        
        _ = self.issueDateLabel
            |> UILabel.lens.text .~ "Order ID: \(value.orderId)"
        
        _ = self.emailLabel
            |> UILabel.lens.text .~ value.email
    }
    
    @objc fileprivate func deleteIssueButtonTapped() {
        self.viewModel.inputs.deletedOrderTapped()
    }
}
