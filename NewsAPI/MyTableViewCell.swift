//
//  MyTableViewCell.swift
//  NewsAPI
//
//  Created by Manise Mutake on 11/19/22.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var myLabelView: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.image = nil
    }

}
