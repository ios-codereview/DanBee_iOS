//
//  SideMenuViewController.swift
//  DanBee_iOS
//
//  Created by 남수김 on 15/08/2019.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let menuList = ["1","2","3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        uiSet()
    }
    
   
    
    @IBAction func loginButtonClick(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") else {return}
        self.present(nextVC, animated: true, completion: nil)
    }
}

extension SideMenuViewController {
    
    func uiSet(){
        self.tableView.separatorColor = UIColor.clear
        //login상태에따른 버튼유무
        if UserInfo.shared.userid.isEmpty {
            self.loginButton.isHidden = false
        }else {
            self.loginButton.isHidden = true
        }
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SideMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menu", for: indexPath) as! SideMenuTableViewCell
        
        cell.menuLabel.text = menuList[indexPath.row]
        return cell
    }
    
    
}
