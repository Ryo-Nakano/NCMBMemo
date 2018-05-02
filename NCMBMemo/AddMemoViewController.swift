//
//  AddMemoViewController.swift
//  NCMBMemo
//
//  Created by Ryohei Nanano on 2018/03/06.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import  NCMB

class AddMemoViewController: UIViewController {
    
    @IBOutlet var memoTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        memoTextView.becomeFirstResponder()//一番最初に応答する！→勝手にキーボード出る！
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //メモ内容を保存する関数
    @IBAction func save()
    {
        let object = NCMBObject(className: "Memo")//MemoクラスのNCMBObjectを作成、変数objectの中に格納→NCMBObjectクラスのメソッド使う為！
        object?.setObject(memoTextView.text, forKey: "memo")//新しいmemo列(key)を作成、memoTextView.textの値をsetする
        object?.saveInBackground({ (error) in
            
            if error != nil//エラー出た時
            {
                print(error)//エラー内容出力
            }
            else//エラーない時
            {
                let alertController = UIAlertController(title: "保存完了", message: "メモの保存が完了しました。メモ一覧に戻ります。", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                     self.navigationController?.popViewController(animated: true)
                })
                alertController.addAction(action)
                self.present(alertController, animated: true, completion: nil)
               
            }
        })
    }

}
