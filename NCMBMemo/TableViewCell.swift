//
//  TableViewCell.swift
//  NCMBMemo
//
//  Created by Ryohei Nanano on 2018/03/06.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
