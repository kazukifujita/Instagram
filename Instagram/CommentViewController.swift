//
//  CommentViewController.swift
//  Instagram
//
//  Created by 藤田 和樹 on 2017/05/08.
//  Copyright © 2017年 藤田 和樹. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD


class CommentViewController: UIViewController {
    


    
    @IBOutlet weak var commentNameText: UILabel!
     @IBOutlet weak var commentText: UITextView!
 
    //ログイン中のユーザーの名前をnameに設定
    let name = FIRAuth.auth()?.currentUser?.displayName
    var postData: PostData!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //ログイン中のユーザーの名前表示（上記のラベルに設定したもの）
           commentNameText.text = name
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func commentPlusButton(_ sender: Any) {
  
        // Firebaseに保存するデータの準備
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            
   
             // コメントした人とコメントの情報を取得する
    
            let commentData = [ "commentname": commentNameText.text!, "comment": commentText.text!] as [String : Any]
            // postDataに必要な情報を取得しておく
            
            
                      // postData.commentsへコメントデータを追記
             postData.comments.append(commentData as! [String : String])
            
            
            // コメントをFirebaseに保存する
             let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id!)
             let comments = ["comments": postData.comments]
             postRef.updateChildValues(comments)
            
            // HUDで投稿完了を表示する
            SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
            
            // 全てのモーダルを閉じる
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
            
        }
    }
    //キャンセルを押された時にホーム画面に戻る
    @IBAction func commentCancelButton(_ sender: Any) {
        // 画面を閉じる
        dismiss(animated: true, completion: nil)
    }
   
}
