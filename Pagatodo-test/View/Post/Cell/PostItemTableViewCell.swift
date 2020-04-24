//
//  PostItemTableViewCell.swift
//  ceiba-test
//
//  Created by Jc on 22/04/20.
//  Copyright © 2020 Jc. All rights reserved.
//

import UIKit

class PostItemTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var postTitle: UILabel!
    @IBOutlet fileprivate weak var postDescription: UILabel!
    @IBOutlet weak var rootContentView: UIView!
    
    var title: String = "" {
        didSet {
            postTitle.text = title
        }
    }
    
    var itemDescription: String = "" {
        didSet {
            postDescription.text = itemDescription
        }
    }
    
    override func prepareForReuse() {
        postTitle.text = ""
        postDescription.text = ""
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootContentView.addShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
