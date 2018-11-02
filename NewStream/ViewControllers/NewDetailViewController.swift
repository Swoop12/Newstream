//
//  NewDetailViewController.swift
//  NewStream
//
//  Created by DevMountain on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class NewDetailViewController: UIViewController {
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var bodyTextView: UITextView!
    
    @objc var news: DVMNews?{
        didSet{
            self.loadViewIfNeeded()
            updateViews()
        }
    }
    
    @objc var photo: UIImage?{
        didSet{
            self.loadViewIfNeeded()
            newsImageView.image = photo
        }
    }
    
    func updateViews(){
        guard let news = news else {return}
        authorLabel.text = news.author
        sourceLabel.text = news.source
        bodyTextView.text = news.content
        self.title = news.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
