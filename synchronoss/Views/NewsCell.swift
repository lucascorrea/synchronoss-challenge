//
//  NewsCell.swift
//  synchronoss
//
//  Created by Lucas Correa on 07/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
