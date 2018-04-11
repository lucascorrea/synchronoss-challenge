//
//  StationDataCell.swift
//  synchronoss
//
//  Created by Lucas Correa on 06/04/2018.
//  Copyright © 2018 SiriusCode. All rights reserved.
//

import UIKit

protocol StationDataCellDelegate: class {
    func chanceAlarmToCell(_ cell: StationDataCell, minutes: Int)
}

class StationDataCell: UITableViewCell {
    
    @IBOutlet weak var trainTypeLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var alarmLabel: UILabel!
    
    //
    // MARK: - Properties
    weak var delegate: StationDataCellDelegate?
    
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
    
    //
    // MARK: - Actions
    @IBAction func alarmAction(_ sender: UIButton) {
        delegate?.chanceAlarmToCell(self, minutes: sender.tag)
    }
    
}
