//
//  NotificationTableViewCell.swift
//  settingTest
//
//  Created by Taehyeon Han on 2018. 7. 30..
//  Copyright © 2018년 calmone. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    static let id = "NotificationTableViewCell"
    
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var radioButtonConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(titleText: String, time: String, isRead: Bool = false) {
        titleLabel.text = titleText
        timeLabel.text = time
        self.backgroundColor = isRead ? .white : UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
        setRadioButton()
    }
    
    private func setRadioButton() {
        self.radioButton.layer.masksToBounds = true
        self.radioButton.layer.cornerRadius = self.radioButton.frame.size.height/2.0
        self.radioButton.layer.borderColor = UIColor.black.cgColor
        self.radioButton.layer.borderWidth = 1
        self.radioButton.setBackgroundColor(color: .clear, forState: .normal)
        self.radioButton.setBackgroundColor(color: .red, forState: .selected)
    }
    
}

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
}
