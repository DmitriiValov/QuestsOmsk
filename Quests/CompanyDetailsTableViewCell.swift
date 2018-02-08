//
//  CompanyDetailsTableViewCell.swift
//  Quests
//
//  Created by Dmitry Valov on 01/04/2017.
//  Copyright © 2017 Dmitry Valov. All rights reserved.
//

import UIKit

class CompanyDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var questNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var complexityLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
