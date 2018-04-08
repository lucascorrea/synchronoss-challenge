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
    
    @IBOutlet weak var detailText: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    //
    // MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //
    // MARK: - Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
