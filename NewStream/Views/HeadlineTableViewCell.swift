//
//  HeadlineTableViewCell.swift
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    @objc var news: DVMNews?{
        didSet{
            updateViews()
            fetchAndSetImage()
        }
    }
    
    func updateViews(){
        guard let news = news else { return }
        titleLabel.text = news.title
        sourceLabel.text = news.source
        let author = nullToNil(value: news.author as AnyObject)
        authorLabel.text = author as? String ?? "None"
    }
    
    func fetchAndSetImage(){
        guard let imageUrl = news?.imageUrl else {return}
        DVMNewsApiClient.fetchImage(forUrl: imageUrl) { (photo) in
            DispatchQueue.main.async {
                self.newsImageView.image = photo
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }

}
