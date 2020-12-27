//
//  InfoTableViewCell.swift
//  Viper Task
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import UIKit
class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transId: UILabel!
    
    @IBOutlet weak var sentNo: UILabel!
    
    @IBOutlet weak var amountLbl: UILabel!
    
    @IBOutlet weak var isCredit: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static var identifier : String {
        return String(describing: self)
    }
    
    static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
