//
//  PropertyCell.swift
//  Properti Anda
//
//  Created by Kendrick on 22/8/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class PropertyCell: UITableViewCell {
    
    @IBOutlet weak var addressLabel:UILabel?
    @IBOutlet weak var progressPriceLabel:UILabel?
    @IBOutlet weak var priceLabel:UILabel?
    @IBOutlet weak var investButton:FlatButton?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
