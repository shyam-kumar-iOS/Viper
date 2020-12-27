//
//  ViewController.swift
//  Viper Task
//
//  Created by Apple on 16/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

enum mode {
    case login
    case register
}

class ViewController: UIViewController {

     var presenter: PresenterInputProtocol?
    
    var mode: mode?
    
    let db = DatabaseHelper()
    
    var mobNossss: Array<MobNo> = Array()
    
    @IBOutlet weak var mobTxtF: UITextField!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    @IBOutlet weak var registerNoBtn: UIButton!
    
    @IBOutlet weak var logoutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        toggleModes()
    }
    @IBAction func BtnAct(_ sender: UIButton) {
    
        if sender.title(for: .normal) == "Register" {
            
            let vc = Router.createModule() as! ViewController
                //storyboard?.instantiateViewController(identifier: "ViewController") as! ViewController
            
            vc.mode = .register
            
            self.navigationController?.pushViewController(vc, animated: true)
         
        
        }else if sender.title(for: .normal) == "Login" {
            
            presenter?.fetchingDb()
            
            mobNossss.forEach { (i) in
                if i.mobileNo == mobTxtF.text {
                    print("isLogin")
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                }
            }
            
            let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
             if isLogin {
      
                presenter?.getResponse(url: "https://foodie.deliveryventure.com/api/user/profile", params: ["Node":"wallet_balance"], { bool in
                    print("sfsdfs", bool)
                    if let bal = UserDefaults.standard.string(forKey: "wallet_balance") {
                      if bal.count > 0 {
                        let vc = Router.MainModule()
                        self.navigationController?.pushViewController(vc, animated: true)
                  }
                }
              })
             }}else {
           
            if !mobTxtF.text!.isEmpty {

                guard let abc = db.add(MobNo.self) else {return}
                abc.mobileNo = mobTxtF.text!
                presenter?.savingDb(mobNo: abc)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func toggleModes() {
        if mode == .register{
            registerBtn.isHidden = true
            logoutBtn.isHidden = true
            registerNoBtn.isHidden = false
        }else {
            registerNoBtn.isHidden = true
            registerBtn.isHidden = false
            logoutBtn.isHidden = false
        }
    }
}

extension ViewController: PresenterOutputProtocol{
   
    func getInfoData(info: Array<Info>) {
        
    }

    func showSuccess(dic: NSDictionary) {
        
        UserDefaults.standard.set("\(dic["wallet_balance"] ?? "")", forKey: "wallet_balance")
        
    }
    
    func showError(error: CustomError) {
        print("err", error)
    }
    
    func getData(mobNos: Array<MobNo>) {
        
        self.mobNossss = mobNos
        print ("retrieved db", mobNos)
    }
    
    func showSaveError() {
        print("")
    }
    
//    func savetoDb(mobNo: MobNo) {
//
//    }
    
//    func saveInfo(info: Info) {
//
//    }
    
    
}

