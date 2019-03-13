//
//  FancyCarCell.swift
//  fancycars
//
//  Created by Marco Lima on 2019-03-11.
//  Copyright © 2019 LIM4. All rights reserved.
//

import UIKit

class FancyCarCell: UITableViewCell {

    @IBOutlet weak var fancyName: UILabel!
    @IBOutlet weak var fancyImage: UIImageView!
    @IBOutlet weak var fancyMake: UILabel!
    @IBOutlet weak var fancyModel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
