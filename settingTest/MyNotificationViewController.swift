//
//  MyNotificationViewController.swift
//  settingTest
//
//  Created by Taehyeon Han on 2018. 7. 30..
//  Copyright © 2018년 calmone. All rights reserved.
//

import UIKit

class MyNotificationViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var selectAllButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var notificationListTableView: UITableView!
    
    var notiList: [Bool] = [false, false, false, true, false, false, false, true, false, false, true, true, false, false, true, true, false, false, true, true]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingViews()
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(longTouchEvent))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        self.notificationListTableView.addGestureRecognizer(lpgr)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func settingViews() {
        notificationListTableView.register(UINib(nibName: NotificationTableViewCell.id, bundle: nil), forCellReuseIdentifier: NotificationTableViewCell.id)
        
        for view in contentsView.subviews {
            view.layer.borderColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0).cgColor
            view.layer.borderWidth = 1
        }
    }
    
    @IBAction private func backButtonPressed(_ sender: Any) {
        if let button = sender as? UIButton, button == backButton {
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction private func selectAllButtonPressed(_ sender: Any) {
        let totalRows = notificationListTableView.numberOfRows(inSection: 0)
        for row in 0..<totalRows {
            if let cell = notificationListTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? NotificationTableViewCell {
                cell.radioButton.isSelected = true
            }
        }
        DispatchQueue.main.async {
            self.notificationListTableView.reloadData()
        }
    }
    
    @IBAction private func deleteButtonPressed(_ sender: Any) {
        var indexPaths: [IndexPath] = []
        
        let totalRows = notificationListTableView.numberOfRows(inSection: 0)
        for row in 0..<totalRows {
            let indexPath = IndexPath(row: row, section: 0)
            if let cell = notificationListTableView.cellForRow(at: indexPath) as? NotificationTableViewCell {
                if cell.radioButton.isSelected {
                    notiList.remove(at: row)
                    indexPaths.append(indexPath)
                }
            }
        }
        
        DispatchQueue.main.async {
            if indexPaths.count > 0 {
                self.notificationListTableView.deleteRows(at: indexPaths, with: .fade)
            }
        }
        
        editable(false)
    }
    
    @objc private func longTouchEvent() {
        editable(true)
    }
    
    private func editable(_ hideBackButton: Bool) {
        self.deleteButton.isHidden = !hideBackButton
        self.selectAllButton.isHidden = !hideBackButton
        self.backButton.isHidden = hideBackButton
        DispatchQueue.main.async {
            self.notificationListTableView.reloadData()
        }
    }

}

extension MyNotificationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiList.count //datacount만큼
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.height / 10.5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.id, for: indexPath) as! NotificationTableViewCell
        cell.configure(titleText: "row : \(indexPath.row)", time: "20.07.2018", isRead: notiList[indexPath.row])
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        cell.radioButton.tag = indexPath.row
        cell.radioButton.addTarget(self, action: #selector(radioButtonPressed(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        notiList[indexPath.row] = true
        DispatchQueue.main.async {
            self.notificationListTableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let c = cell as? NotificationTableViewCell {
            c.radioButtonConstraint.constant = self.deleteButton.isHidden ? -20 : 15
        }
    }
    
    @objc private func buttonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            print("pressed Button Tag : \(button.tag)")
        }
    }
    
    @objc private func radioButtonPressed(_ sender: Any) {
        if let button = sender as? UIButton {
            print("pressed Radio Button Tag : \(button.tag)")
            button.isSelected = !button.isSelected
        }
    }
    
}
