//
//  IssuedListCurrencyCell.swift
//  TiketReactions
//
//  Created by Firas Rafislam on 06/11/18.
//  Copyright © 2018 Firas Rafislam. All rights reserved.
//

import Prelude
import TiketKitModels
import UIKit

internal final class LoungeCurrencyCell: UITableViewCell, ValueCell {
    
    typealias Value = String
    
    @IBOutlet private weak var currencyTitleLabel: UILabel!
    @IBOutlet private weak var currencyValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureWith(value: String) {
        _ = self.currencyValueLabel
            |> UILabel.lens.text .~ value
    }
    
}
