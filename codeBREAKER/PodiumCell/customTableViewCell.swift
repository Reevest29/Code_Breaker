//
//  customTableViewCell.swift
//  codeBREAKER
//
//  Created by user145843 on 10/25/18.
//  Copyright © 2018 T3Tech. All rights reserved.
//

import UIKit

class customTableViewCell: UITableViewCell {
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
