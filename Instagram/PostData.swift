//
//  PostData.swift
//  Instagram
//
//  Created by 藤田 和樹 on 2017/05/06.
//  Copyright © 2017年 藤田 和樹. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData: NSObject {
    var id: String?
    var image: UIImage?
    var imageString: String?
    var name: String?
    var caption: String?
    var date: NSDate?
    var likes: [String] = []
    var isLiked: Bool = false
    
    //コメントを保存させるポスト的なもの
   // いらないので削除→var commentname: String?
    //いらないので削除→var comment: String?
    
    var comments = [[String:String]]()
    
    init(snapshot: FIRDataSnapshot, myId: String) {
        self.id = snapshot.key
        
        let valueDictionary = snapshot.value as! [String: AnyObject]
        
        imageString = valueDictionary["image"] as? String
        image = UIImage(data: NSData(base64Encoded: imageString!, options: .ignoreUnknownCharacters)! as Data)
        
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
     
         //コメント用のポスト追加↓                               //  コメントが保存される
        if let comments = valueDictionary["comments"] as? [[String : String]] {
            self.comments = comments
        }
        let time = valueDictionary["time"] as? String
        self.date = NSDate(timeIntervalSinceReferenceDate: TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
    }
  }


