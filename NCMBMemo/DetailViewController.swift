//
//  DetailViewController.swift
//  NCMBMemo
//
//  Created by Ryohei Nanano on 2018/03/06.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import NCMB//NCMB使う為の準備
import SVProgressHUD//SVProgressHUDを使う為の準備

class DetailViewController: UIViewController {
    
    @IBOutlet var memoTextView: UITextView!
    var selectedMemo: NCMBObject!//NCMBObject型の変数selectedMomoを宣言！→前の画面から値を受け取る為のハコ。受け取るべき値がNCMBObject型だからこっちもNCMBObject型

    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.text = selectedMemo.object(forKey: "memo") as! String//"memo"Keyで保存されている値を取得→String型にダウンキャストしてmemoTextView.textの中にブチ込む
        //selectedMemo自体は『NCMBObject型』の変数だから、この中から欲しいデータだけ抜き取って表示してあげなきゃいけないことに注意！

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //更新する関数
    @IBAction func update()
    {
        selectedMemo.setObject(memoTextView.text, forKey: "memo")//memoTextView.textの値を"memo"のKeyでセット
        selectedMemo.saveInBackground { (error) in
            
            if error != nil//エラー出た時
            {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
            else//エラー出なかった時
            {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func delet()
    {
        selectedMemo.deleteInBackground { (error) in
            
            if error != nil//エラー出た時
            {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
            }
            else//エラー出なかった時
            {
                self.navigationController?.popViewController(animated: true)//NavigationController使っている時の前の画面に戻るメソッド
            }
        }
    }
    
}
