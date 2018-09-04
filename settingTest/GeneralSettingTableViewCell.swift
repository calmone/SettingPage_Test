//
//  GeneralSettingTableViewCell.swift
//  settingTest
//
//  Created by Taehyeon Han on 2018. 7. 30..
//  Copyright © 2018년 calmone. All rights reserved.
//

import UIKit

class GeneralSettingTableViewCell: UITableViewCell {
    
    static let id = "GeneralSettingTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ title: String, isSelected: Bool) {
        titleLabel.text = title
        settingSwitch.isOn = isSelected
    }
}
