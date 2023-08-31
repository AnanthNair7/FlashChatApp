//
//  MessageCell.swift
//  FlashChat
//
//  Created by Ananth Nair on 28/08/23.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var lable: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    
    @IBOutlet weak var youImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        messageBubble.layer.cornerRadius = messageBubble.frame.size.height / 4 
        // Configure the view for the selected state
    }
    
}
