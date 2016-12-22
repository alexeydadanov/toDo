//
//  itemTableViewCell.swift
//  toDo
//
//  Created by Dadanov Alexey on 21.12.16.
//  Copyright © 2016 Dadanov Alexey. All rights reserved.
//

import UIKit

class itemTableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
