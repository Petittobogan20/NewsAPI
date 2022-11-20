//
//  ReadNewsContent.swift
//  NewsAPI
//
//  Created by Manise Mutake on 11/20/22.
//

import UIKit

class ReadNewsContent: UIViewController {

    
    
    @IBOutlet weak var myLabel2: UILabel!
    
    @IBOutlet weak var myLabelView: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    var newsContent:NewsData = NewsData(newstitle: "", newscontent: "", newsimage: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if newsContent.newsimage != nil
        {
            let url = URL(string: "http://haritibhakti.com/\(newsContent.newsimage!)")
            myImageView.downloadImage(from: url!)
            myImageView.contentMode = .scaleToFill
        }
        else{
            myImageView.image = UIImage(named: "emptyimage")
        }
        myLabelView.text = newsContent.newstitle
        myLabel2.text = newsContent.newscontent
    }

}
