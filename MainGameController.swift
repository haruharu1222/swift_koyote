//
//  MainGameController.swift
//  otamesi
//
//  Created by 山口遥陽 on 2020/08/15.
//  Copyright © 2020 山口遥陽. All rights reserved.
//

import UIKit



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.hideKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}



class MainGameController: UIViewController, UITextFieldDelegate {
    
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate //AppDelegateのインスタンスを取得　
    
    
    
    var n = 2
    
    //テスト用
    @IBOutlet weak var MyLabel: UILabel!
    
    //答えを入力するテキストフィールド
    @IBOutlet weak var kotae_field: UITextField!

    //プレイヤーのカード
    @IBOutlet weak var image_pzero: UIImageView!
    @IBOutlet weak var image_pone: UIImageView!
    @IBOutlet weak var image_ptwo: UIImageView!
    
    //場の数字
    @IBOutlet weak var nowNumber: UIButton!
    
    //nul?
    var num:String?
    
    //場の数字
    var nowNumberString:String?
    var nowNumberInt:Int = 0
    
    
    //現在のプレイヤー
    var nowplayerid:Int = 0
    
    //プレイヤーの入力(String)
    var kotaeFieldString:String = ""
    var kotaeFieldInt:Int = 0
    var is_input:Int = 0    //入力されたかどうか

    //var player_card = [Int](repeating: 2, count: 4)
    var selected_card = [Int](repeating: 0, count: 14)
    
    //結果関係
    var loser:Int = 0
    
    
    /*
     player ID
     n = 3  ->  0（自分）, 1, 2
     n = 4  ->  0（自分）, 1, 2, 3
    */

    /*
    about SELECTED_CARD

    0 -> -10    １枚まで
    1 -> -5　　　2枚まで
    2 -> 0
    3 -> 1
    4 -> 2
    5 -> 3
    6 -> 4
    7 -> 5
    8 -> 10     3枚まで
    9 -> 15     2枚まで
    10 -> 20     １枚まで
    11 -> ×2     １枚まで
    12 -> max→0　 １枚まで
    13 -> ?      １枚まで
    */
    
    
    //便利な変数
    var x:Int = 0
    var player_hatena:Int = 0
    var replace_hatena:Int = 0
    
    
    
    
    
    func IsSelect(_ selectnumber:Int)->Bool{
        if selectnumber >= 1 && selectnumber <= 5{
            return true
        }else if selectnumber == 1 || selectnumber == 9{
            if selected_card[selectnumber] < 2{
                return true
            }
        }else if selectnumber == 8{
            if selected_card[selectnumber] < 3{
                return true
            }
        }else{
            if selected_card[selectnumber] < 1{
                return true
            }
        }
        return false
    }
    
    
    
    func WhichImage(_ selectnumber:Int)->String{
        switch selectnumber {
            case 0:
                return "card_mju"
            case 1:
                  return "card_mgo"
            case 2:
                return "card_zero"
            case 3:
                  return "card_iti"
            case 4:
                return "card_ni"
            case 5:
                  return "card_san"
            case 6:
                  return "card_yon"
            case 7:
                  return "card_go"
            case 8:
                  return "card_ju"
            case 9:
                  return "card_jugo"
            case 10:
                  return "card_niju"
            case 11:
                  return "card_nibai"
            case 12:
                  return "card_maxzero"
            default:
                  return "card_hatena"
        }
    }
    
    
    //カードを配る処理
    func HandoutCard(){
        for i in 0...n{
           repeat{
                appDelegate.player_card[i] = Int.random(in: 0...13)
           }while((!IsSelect(appDelegate.player_card[i])))
           
           //”はてな”が引かれた時の処理
           if  appDelegate.player_card[i] == 13{
               repeat{
                   replace_hatena = Int.random(in: 0...13)
               }while((!IsSelect(replace_hatena)))
               player_hatena = i
               selected_card[replace_hatena] += 1
           }
            selected_card[ appDelegate.player_card[i]] += 1
        }

        image_pone.image = UIImage(named: WhichImage(appDelegate.player_card[1]))
        image_ptwo.image = UIImage(named: WhichImage(appDelegate.player_card[2]))
    }
    

    
    //プレイヤーのカードの合計計算関数
    func CulcpSum()->Int {
        if selected_card[12] == 1 {
            for i in 0...10{
                if selected_card[10-i] > 0 {
                    selected_card[10-i] -= 1
                    break
                }
            }
        }
        x += selected_card[0]*(-10)
        x += selected_card[1]*(-5)
        x += selected_card[3]
        x += selected_card[4]*2
        x += selected_card[5]*3
        x += selected_card[6]*4
        x += selected_card[7]*5
        x += selected_card[8]*10
        x += selected_card[9]*15
        x += selected_card[10]*20
        return x * Int(pow(2.0, Double(selected_card[11])))
    }
    
    
    
    //直前のプレイヤーID
    func PrePlayerId(_ playerid:Int)->Int{
        if playerid == 0{
            return n
        }else{
            return playerid - 1
        }
    }
    
    
    
    //コヨーテボタンを押された時の処理
    func WhoLose(_ playerid:Int)->Int{
        appDelegate.psum = CulcpSum()
        if nowNumberInt > appDelegate.psum {
            return PrePlayerId(playerid)
        }else{
            return playerid
        }
   }
    

    //数字のみを受け付ける
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return string == numberFiltered
    }
    
    //returnキーでキーボード閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        //outputText.text = textField.text
        return true
    }
    
    
    
    
    
    
    
    
    

    
    
    
////////////////////////////////////////////////////////////////////////
//画面が変わった時の処理
////////////////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        hideKeyboardWhenTappedAround()
        
        kotae_field.delegate = self
        
        HandoutCard()

        //image_pthree.image = UIImage(named: which_image(player_card[3]))
                
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

 
    
  
    
    
////////////////////////////////////////////////////////////////////////
//入力フォームの処理
////////////////////////////////////////////////////////////////////////
    
    @IBAction func inputText(_ sender: UITextField) {
        //test
        //MyLabel.text = nowNumber.currentTitle;
    }

    

////////////////////////////////////////////////////////////////////////
//答えを送信ボタンの処理
////////////////////////////////////////////////////////////////////////
    
    @IBAction func answer(_ sender: Any) {
        
        if kotae_field.text! == ""{
           kotae_field.placeholder = "入力して！"
        }else{
            nowNumberString = nowNumber.currentTitle
            kotaeFieldString = kotae_field.text!
            kotaeFieldInt = Int(kotae_field.text!)!
            
            if nowNumberString != nil {
                nowNumberInt = Int(nowNumberString!)!
             
                if kotaeFieldInt > 70 {
                    kotae_field.placeholder = "大きすぎる！"
                }else if kotaeFieldInt < -30{
                    kotae_field.placeholder = "小さすぎる！"
                }else if nowNumberInt<kotaeFieldInt {
                    nowNumber.setTitle(kotaeFieldString, for: .normal)
                    kotae_field.placeholder = "答えを入力"
                }else{
                    kotae_field.text = nil
                    kotae_field.placeholder = "上の数より大きく！"
                  }
            }else{
                nowNumber.setTitle(kotaeFieldString, for: .normal)
                kotae_field.placeholder = "答えを入力"
            }
        }
        
        //入力フォームの中身を初期化
        kotae_field.text = nil
    }
    
  
////////////////////////////////////////////////////////////////////////
//コヨーテボタンの処理
////////////////////////////////////////////////////////////////////////

    @IBAction func koyote(_ sender: Any) {
        nowNumberString = nowNumber.currentTitle
        
        //リザルト画面へ
        if nowNumberString != nil{
            appDelegate.loser = WhoLose(nowplayerid)
            appDelegate.koyote_number =  Int(nowNumberString!)!
            
            //画面遷移
            self.performSegue(withIdentifier: "toResult", sender: nil)
        }else{
            kotae_field.placeholder = "最初の数字！"
        }
    }
    
    
    
    
//
override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
}
    
}
