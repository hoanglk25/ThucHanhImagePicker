//
//  TableViewCell.swift
//  ThucHanhImagePicker
//
//  Created by Hoàng Đức on 18/11/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
     makeCircle()
    }
    
    func makeCircle() {
        avatarImageView.layer.cornerRadius = 45
        avatarImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
