//
//  TrxnViewController.swift
//  Viper Task
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   

    var presenter: PresenterInputProtocol?
    
    var details = Array<Info>()
    
    @IBOutlet weak var tblV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblV.register(InfoTableViewCell.nib, forCellReuseIdentifier: InfoTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.isNavigationBarHidden = false
        presenter?.fetchInfo()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as! InfoTableViewCell
        
        let currentDetails = details[indexPath.row]
        
        cell.transId.text = currentDetails.id
        cell.sentNo.text = currentDetails.storedNo
        cell.amountLbl.text = currentDetails.amount
        cell.isCredit.text = (currentDetails.isCredit) ? "Credit" : "Debit"
        cell.isCredit.backgroundColor = (currentDetails.isCredit) ? .green : .red
        cell.isCredit.textColor = (currentDetails.isCredit) ? .darkGray : .white
        cell.backgroundColor = .green
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        return 150
    
    }
}

extension DetailViewController: PresenterOutputProtocol {
   
    func showSuccess(dic: NSDictionary) {
        
    }
    
    func showError(error: CustomError) {
    
    }
    
    func getData(mobNos: Array<MobNo>) {
        
    }
    
    func showSaveError() {
        print("save error")
    }

    func getInfoData(info: Array<Info>) {
        self.details = info
    }
    
//    func saveInfo(info: Info) {
//        
//    }
    
//    func savetoDb(mobNo: MobNo) {
//
//    }
    
    
}
