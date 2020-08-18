//
//  ResultController.swift
//  otamesi
//
//  Created by 山口遥陽 on 2020/08/18.
//  Copyright © 2020 山口遥陽. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var card_pone: UIImageView!
    @IBOutlet weak var card_ptwo: UIImageView!
    @IBOutlet weak var card_pzero: UIImageView!
    
    @IBOutlet weak var now_number: UIButton!
    
    @IBOutlet weak var sum_number: UILabel!
    @IBOutlet weak var lose_player: UILabel!
    
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
    
    func IdToPlayerName(_ playerid:Int)->String{
        switch playerid {
        case 0:
            return "player0"
        case 1:
            return "player1"
        case 2:
            return "player2"
        default:
            return "player3"
        }
    }

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        card_pzero.image = UIImage(named: WhichImage(appDelegate.player_card[0]))
        card_pone.image = UIImage(named: WhichImage(appDelegate.player_card[1]))
        card_ptwo.image = UIImage(named: WhichImage(appDelegate.player_card[2]))
        sum_number.text = "みんなのカードの合計は\(appDelegate.psum)"
        lose_player.text = "負けたのは" + IdToPlayerName(appDelegate.loser)
        
        now_number.setTitle("\(appDelegate.koyote_number)", for: .normal)
        
        //card_pone.image = UIImage(named: WhichImage(appDelegate.player_card[3]))

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
