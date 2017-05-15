//
//  PostTableViewCell.swift
//  
//
//  Created by 藤田 和樹 on 2017/05/06.
//
//

import UIKit
protocol PostTableViewCelldelegate{
    
    func commentBUtton_Clicked(cell: PostTableViewCell)
    
}

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
//ユーザー名とコメントが表示されるテキスト
    @IBOutlet weak var commentLabel: UILabel!
    
    var delegate: PostTableViewCelldelegate!
    
    
    

    override func awakeFromNib() {
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setPostData(postData: PostData) {
        self.postImageView.image = postData.image
        
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        
        
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
     //self.commentLabel.text = "\(comments["commentname"]) : \(comments["comment"])\n"（前までのコード）
             /////コメント名:コメント内容 改行で要素文繰り返す
        var commentText = ""
        for comment in postData.comments {
            
            // コメント名 : コメント内容 改行で要素文繰り返す 
            commentText += "\(comment["commentname"]!) : \(comment["comment"]!)\n"
               
            //コメントが増えるごとにラベルの高さを自動調整
            commentLabel.numberOfLines = 0
            commentLabel.sizeToFit()
            commentLabel.lineBreakMode = .byWordWrapping
            commentLabel.font = UIFont(name: "HirakakuProN-W6", size:15)
            
        }
        self.commentLabel.text = commentText

        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: UIControlState.normal)
        }
    }

}
    
