//
//  PostCell.swift
//  campus-connect
//
//  Created by Gabriel Meruvia on 1/18/17.
//  Copyright © 2017 Gabriel Meruvia. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var userNameLbl : UILabel!
    @IBOutlet weak var postImg : UIImageView!
    @IBOutlet weak var caption : UITextView!
    @IBOutlet weak var likesLbl : UILabel!
    
    var post: Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell (post: Post){
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
    }
}
