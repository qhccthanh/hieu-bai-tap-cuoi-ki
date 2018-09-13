//
//  UserViewController.swift
//  AcoutApp
//
//  Created by James on 9/10/18.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var currentStatusID: Int = 0
    var users: [UserInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
        }
        
        FirebaseData.shared.ref.child("users").observe(.value) { (snapShot) in
            print(snapShot.value)
            self.bindingUI(users: snapShot.value as? [String : Any])
        }
        
    }
    
    func bindingUI(users: [String: Any]?) {
        
        self.users.removeAll()
        
        guard let users = users else {
            self.users = []
            self.tableView.reloadData()
            return
        }
        
        for value in users.values {
            if let userValue = value as? [String: Any] {
                let avatarURL = userValue["avatar"] as? String
                let name = userValue["name"] as? String
                let id = userValue["id"] as? String ?? ""
                let email = userValue["email"] as? String
                let dialogIDs = userValue["dialog_ids"] as? [String] ?? []
                let status = userValue["status"] as? Int ?? 0
                
                let userInfo = UserInfo(id: id)
                userInfo.name = name
                userInfo.avatar = avatarURL
                userInfo.email = email
                userInfo.dialogIDs = dialogIDs
                userInfo.status = status
                
                self.users.append(userInfo)
            }
        }
        
        self.tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // UserManager.shared.getCurrentUser()?.uid == userInfo.uid ? true : false
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        let userInfo = self.users[indexPath.row]
        cell.textLabel?.text = userInfo.id
        cell.detailTextLabel?.text = userInfo.name
        // UISwitch
        // cell.aSwitch.isOn = userInfo.isOnline
        
        if userInfo.status == 0 {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .gray
        }
        
        return cell
    }
    
    @IBAction func logOutBtn(_ sender: Any!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //@IBAction func changeStatus(_ sender: Any!) {
        
      //  guard let currentUserUID = UserManager.shared.getCurrentUser()?.uid else {
        //    return
        //}
        
       // FirebaseData.shared.userRef.child(currentUserUID).child("status").setValue(self.currentStatusID)
        
        //if self.currentStatusID == 0 {
          //  self.currentStatusID = 1
        //} else {
          //  self.currentStatusID = 0
        //}
    //}
}
