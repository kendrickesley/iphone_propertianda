//
//  InvestCell.swift
//  Properti Anda
//
//  Created by Kendrick on 26/9/17.
//  Copyright © 2017 Kendrick. All rights reserved.
//

import UIKit
import Material

class InvestCell: UITableViewCell {

    @IBOutlet weak var addressLabel:UILabel?
    @IBOutlet weak var contributionLabel:UILabel?
    @IBOutlet weak var priceLabel:UILabel?
    @IBOutlet weak var propertyImage:UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
