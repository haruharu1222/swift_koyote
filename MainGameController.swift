//
//  MainGameController.swift
//  otamesi
//
//  Created by 山口遥陽 on 2020/08/15.
//  Copyright © 2020 山口遥陽. All rights reserved.
//

import UIKit


class MainGameController: UIViewController {
    
    
    var n = 3
    
    //テスト用
    @IBOutlet weak var MyLabel: UILabel!
    
    //答えを入力するテキストフィールド
    @IBOutlet weak var kotae_field: UITextField!

    //プレイヤーのカード
    @IBOutlet weak var image_pone: UIImageView!
    @IBOutlet weak var image_ptwo: UIImageView!
    
    //場の数字
    @IBOutlet weak var nowNumber: UIButton!
    
    //nul?
    var num:String?
    
    //場の数字
    var nowNumberString:String?
    var nowNumberInt:Int = 0
    
    //プレイヤーの入力(String)
    var kotaeFieldString:String = ""
    var kotaeFieldInt:Int = 0

    var player_card = [Int](repeating: 2, count: 4)
    var selected_card = [Int](repeating: 0, count: 14)

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
    
    
    func is_select(_ selectnumber:Int)->Bool{
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
    
    
    
    func which_image(_ selectnumber:Int)->String{
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        for i in 0...n{
            repeat{
                player_card[i] = Int.random(in: 0...13)
            }while((!is_select(player_card[i])))
            
            selected_card[player_card[i]] += 1
        }

        image_pone.image = UIImage(named: which_image(player_card[0]))
        image_ptwo.image = UIImage(named: which_image(player_card[1]))
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

  

  
    
    
    
    
    
    @IBAction func inputText(_ sender: UITextField) {
        kotaeFieldString = kotae_field.text!
        kotaeFieldInt = Int(kotae_field.text!)!
       
        
        //test
        //MyLabel.text = nowNumber.currentTitle;
    }

    @IBAction func answer(_ sender: Any) {
        nowNumberString = nowNumber.currentTitle
        if nowNumberString != nil {
            nowNumberInt = Int(nowNumberString!)!
            if nowNumberInt<kotaeFieldInt {
                nowNumber.setTitle(kotaeFieldString, for: .normal)
            }else{
                kotae_field.text=nil
                kotae_field.placeholder = "小さすぎ！"
            }
        }else{
            nowNumber.setTitle(kotaeFieldString, for: .normal)
        }
        
    }
    
    
override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
}
    
//Enterを押したらキーボードが閉じるようにするためのコードです。
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return false
    }
    
}
