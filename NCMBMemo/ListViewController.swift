//
//  ListViewController.swift
//  NCMBMemo
//
//  Created by Ryohei Nanano on 2018/03/06.
//  Copyright © 2018年 GeekSalon. All rights reserved.
//

import UIKit
import NCMB//NCMB使う為の準備

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {//プロトコル宣言
    
    let cellID = "TableViewCell"
    let cellName = "TableViewCell"
    
    @IBOutlet var tableView: UITableView!
    var memoArray = [NCMBObject]()//NCMBObjectの空の配列

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //カスタムセルの登録
        let nib = UINib(nibName: cellName, bundle: Bundle.main)//cellNameの名前がついたnibファイルを取得→変数nibの中に格納
        tableView.register(nib, forCellReuseIdentifier: cellID)//変数nibの中に入っているcellをcellIDを持っているカスタムセルとして登録？
        
        //TableViewの不要な線を消す
        tableView.tableFooterView = UIView()
    }
    
    //画面生成時に毎回呼ばれる関数
    override func viewWillAppear(_ animated: Bool) {
        loadData()//データの読み込みを行う関数
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //1.TableVIewに表示するデータの個数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
        return memoArray.count//memoArrayの数と同じだけデータ表示
    }
    
    //2.TableViewに表示するデータの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //再利用するセルの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableViewCell//cellIDのついたcellを取得、TableViewCell型にダウンキャストして変数"cell"の中に格納
        
        //実際に表示する内容の記述
        cell.label.text = memoArray[indexPath.row].object(forKey: "memo") as? String//"memo"Key持っている値を取得→String型にダウンキャスト
        
        return cell
    }
    
    //TableViewのどの列が押されたかを判定する関数
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: nil)//画面遷移("toDetail"のタグがついているsegueの先に遷移)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面の取得
        if segue.identifier == "toDetail"//segueのIDが"toDetail"だった時ifの先に潜る
        {
            let detailViewController = segue.destination as! DetailViewController//目的地の画面を取得→DetailViewController型にダウンキャストして変数detailViewControllerの中に格納(UnityのGetComponentとかGameObject.Findとかとイメージ同じ！)
            let selectedIndex = tableView.indexPathForSelectedRow!//選択されているcellの行を取得→変数selectedIndexに格納
            detailViewController.selectedMemo = memoArray[selectedIndex.row]//detailViewController内の変数selectedMemoに対して、現在選ばれているcellのmemoArrayの値を格納
        }
    }
    
    //データの読み込みを行う関数
    func loadData()
    {
        let query = NCMBQuery(className: "Memo")//Memoクラスのqueryを取得→変数queryの中に格納
        query?.findObjectsInBackground({ (result, error) in//バックグラウンドでObjectを取得
            
            if error != nil//エラーある時
            {
                print(error)//エラー内容の出力
            }
            else//エラーない時
            {
                self.memoArray = result as! [NCMBObject]//resultの値を取得、[NCMBObject]型にダウンキャストして変数memoArrayの中に格納
                self.tableView.reloadData()//tableViewの再度読み込み！
            }
        })
    }

}
