//
//  MainViewController.swift
//  Viper Task
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: PresenterInputProtocol?
    
    var bal: String?
    
    @IBOutlet weak var popUpV: UIView!
    
    @IBOutlet weak var balanceLbl: UILabel!
    
    @IBOutlet weak var mobileTxtF: UITextField!
    
    @IBOutlet weak var amountTxtF: UITextField!
    
    @IBOutlet weak var switchStatus: UISwitch!
    
    let mobileArr = ["" ,"97909790847", "9983456875", "9953367888"]
    
    var randomStr = String()
    
    var deductedStr = String()
    
    var pickerV = UIPickerView()
    
    var mobNosss = Array<MobNo>()
    
    var inffoos = Array<Info>()
    
    let dB = DatabaseHelper()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerV.dataSource = self
        pickerV.delegate = self
        mobileTxtF.inputView = pickerV
        popUpV.alpha = 0
        balanceLbl.text = UserDefaults.standard.string(forKey: "wallet_balance")

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    @IBAction func toggleOptions(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: "Toggle Option", message: "Please select a option", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction.init(title: "Transaction List", style: .default, handler: { (action) in
        
            self.presenter?.fetchInfo()
         
            
            if self.inffoos.count > 0 {
          
                let firstVC = Router.TrxnModule()
            self.navigationController?.pushViewController(firstVC, animated: true)
            }else {
                self.showToast(message: "No transaction yet", font: .systemFont(ofSize: 12.0))
            }
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Send Money", style: .default, handler: { (action) in
            
            self.amountTxtF.text = ""
            self.mobileTxtF.text = ""
            self.popUpV.fadeIn()
            self.randomStr = ""
            for _ in 0...3 {
                         
                let randomInt = self.random(1..<8)
                self.randomStr += "\(randomInt)"
                 
             }
            print("random", self.randomStr)

        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Logout", style: .default, handler: { (action) in
            
         
            UserDefaults.standard.set(false, forKey: "isLogin")
            
            self.presenter?.fetchingDb()
            
            self.mobNosss.forEach { (i) in
                self.dB.delete(object: i)
            }
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let firstVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            
             let nav = UINavigationController(rootViewController: firstVC)
            nav.modalPresentationStyle = .fullScreen
            self.navigationController?.present(nav, animated: true, completion: nil)
  
        }))

        self.present(actionSheet, animated: true, completion: nil)
        
    }

    @IBAction func btnAct(_ sender: UIButton) {
   
        if sender.title(for: .normal) == "Send" {
           
            let walletBalance = UserDefaults.standard.integer(forKey: "wallet_balance")
            
            if (Int(amountTxtF.text ?? "")! <= walletBalance) {
           
            
            guard let info = dB.add(Info.self) else {return}

            if let amount = amountTxtF.text {
               
                info.amount = amount
                
            }

            if let storedNo = mobileTxtF.text {
                info.storedNo = storedNo
            }

            info.id = "TRNX\(randomStr)"

            if switchStatus.isOn {
                info.isCredit = false
            }else {
                info.isCredit = true
            }
            
            presenter?.saveInfo(info: info)

            
            let currentAmount = Int(amountTxtF.text ?? "")
            
            deductedStr = "\((walletBalance - (currentAmount ?? 0)))"
            
            print("gygy", deductedStr)
            
            UserDefaults.standard.setValue("\(deductedStr)", forKey: "wallet_balance")
            
            balanceLbl.text = UserDefaults.standard.string(forKey: "wallet_balance")
            
            popUpV.fadeOut()
            
            }else {
                showToast(message: "Insuffient balance", font: .systemFont(ofSize: 12))
               
        }
    
        }else {
            popUpV.fadeOut()
        }
    
    }
    func random(_ range:Range<Int>) -> Int
    {
        return range.lowerBound + Int(arc4random_uniform(UInt32(range.upperBound - range.lowerBound)))
    }
    
    
    
}

extension MainViewController: PresenterOutputProtocol{
  
    func getInfoData(info: Array<Info>) {
        self.inffoos = info
    }
    
    func showSuccess(dic: NSDictionary) {
        
    }
    
    func showError(error: CustomError) {
        
    }
    
    func getData(mobNos: Array<MobNo>) {
       
        self.mobNosss = mobNos
        
        print ("retrieved db", mobNos)
    }
    
    func showSaveError() {
        
    }
    
//    func savetoDb(mobNo: MobNo) {
//
//    }
//
//    func saveInfo(info: Info) {
//
//    }
    
    
}

extension MainViewController : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
        return 1
    
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        return mobileArr.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return mobileArr[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        mobileTxtF.text = mobileArr[row]
        
        mobileTxtF.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
}



extension UIView {

  func fadeIn(duration: TimeInterval = 0.5,
              delay: TimeInterval = 0.0,
              completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
    UIView.animate(withDuration: duration,
                   delay: delay,
                   options: UIView.AnimationOptions.curveEaseIn,
                   animations: {
      self.alpha = 1.0
    }, completion: completion)
  }

  func fadeOut(duration: TimeInterval = 0.5,
               delay: TimeInterval = 0.0,
               completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
    UIView.animate(withDuration: duration,
                   delay: delay,
                   options: UIView.AnimationOptions.curveEaseIn,
                   animations: {
      self.alpha = 0.0
    }, completion: completion)
  }
}

