//
//  ViewController.swift
//  settingTest
//
//  Created by Taehyeon Han on 2018. 7. 30..
//  Copyright © 2018년 calmone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var settingListTableView: UITableView!
    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var contentsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        settingViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func settingViews() {
        settingListTableView.register(UINib(nibName: "GeneralSettingTableViewCell", bundle: nil), forCellReuseIdentifier: GeneralSettingTableViewCell.id)
        
        for view in contentsView.subviews {
            view.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
            view.layer.borderWidth = 1
        }
    }
    
    @IBAction private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            switch button.tag {
            case 0: print("\(button.tag) pressed : page back button")
            case 1:
                print("\(button.tag) pressed : notification list button")
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "MyNotificationViewController")
                self.present(newViewController, animated: true, completion: nil)
            default: break
            }
        }
    }
    
    @IBAction private func notificationAllSwitchIsChanged(_ sender: Any) {
        if let notificationAllSwitch = sender as? UISwitch {
            let totalRows = settingListTableView.numberOfRows(inSection: 0)
            for row in 0..<totalRows {
                if let cell = settingListTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? GeneralSettingTableViewCell {
                    cell.settingSwitch.setOn(notificationAllSwitch.isOn, animated: true)
                }
            }
        }
    }
    
    @objc private func switchIsChanged(_ sender: Any) {
        if let settingSwitch = sender as? UISwitch {
            print("settingSwitch tag : \(settingSwitch.tag)")
            print("settingSwitch isOn : \(settingSwitch.isOn)")
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //dataCount만큼 생성
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 6.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GeneralSettingTableViewCell.id, for: indexPath) as! GeneralSettingTableViewCell
        cell.configure("row: \(indexPath.row)", isSelected: false)
        cell.settingSwitch.tag = indexPath.row
        cell.settingSwitch.addTarget(self, action: #selector(switchIsChanged(_:)), for: .valueChanged)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
}
