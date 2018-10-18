//
//  ViewController.swift
//  Today's_lunch
//
//  Created by minagi on 2018/10/07.
//  Copyright © 2018年 minagi. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
 
    @IBOutlet weak var girlImage: UIImageView!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var girlText: UILabel!
    @IBOutlet weak var frame: UIImageView!
    @IBOutlet weak var backScreen: UIImageView!
    
    var numberOfText = 0
    var random = 0
    var girlVoice : AVAudioPlayer!

    @IBAction func buttonTapped(_ sender: Any) {
    
        random = Int(arc4random_uniform(8))
        
        var imageData = ["girl_nomal","girl_nomal","girl_surprised","girl_troubled","girl_happy","girl_fun"]
        
        //ランチの内容
        var selectLunch = [
            "生姜焼きがいいです。\n定食屋さんに行きませんか？",
            "サンドイッチの気分です。\nタマゴサンド、好きなんですよ。",
            "ツナマヨおにぎりが食べたいです。\nあ、でもシャケも捨てがたいかも。",
            "おそば屋さんに行きませんか？\n温かいのと冷たいの、\nどっちがいいでしょうか。",
            "海鮮丼が食べたいです。\n美味しいお店知ってるんですよ！",
            "パスタにしましょう！\n何パスタがいいか悩んじゃいますね。",
            "焼きたてのパンが食べたいです。\nパン屋さんっていい匂いしますよねぇ。",
            "オムライスなんてどうでしょう。\nふわふわのオムレツが乗ってるやつです！"]
        
        //セリフの内容
        var serif = [
            "タップしてスタート！",
            "おつかれさま。\nお昼、何食べましょうか。",
            "えっ、わたしが決めるんですか？",
            "えーと・・・じゃあ・・・",
            selectLunch[random],
            "ほらほら、時間なくなっちゃいますよ。\n早く食べに行きましょう！"]
    
        //ランチメニューのボイスデータ
        var menuVoice = ["生姜焼き","サンドイッチ","おにぎり","そば","海鮮丼","パスタ","パン","オムライス"]
        
        //セリフのボイスデータ
        var voiceData = ["ボイス1","ボイス2","ボイス3",menuVoice[random],"ボイス5","無音"]
        
        //ボイスデータを指定
        let audioPath = Bundle.main.path(forResource: voiceData[numberOfText], ofType:"mp3")
        let audioUrl = URL(fileURLWithPath: audioPath!)
        
        //ボイスデータを再生するためのプレイヤーを作る
        var audioError : NSError?
        do {
            girlVoice = try AVAudioPlayer(contentsOf: audioUrl)
        }catch let error as NSError {
            audioError = error
            girlVoice = nil
        }
        
        //エラーが起きた時
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        girlVoice.delegate = self
        girlVoice.prepareToPlay()
    
        
        //ボタンを押した時の処理
        if numberOfText == 5 {
            viewDidLoad()
            tapButton.setImage(UIImage(named: "進む")!, for: UIControl.State())
        } else {
            numberOfText += 1
            
            //最後のセリフだったらボタンを「戻る」に変える
            if numberOfText == 5 {
                tapButton.setImage(UIImage(named: "戻る")!, for: UIControl.State())
            }
            
            //顔グラを変える
            let face = UIImage(named: imageData[numberOfText])
            girlImage.image = face
            
            //セリフを表示する
            girlText.numberOfLines = 0
            girlText.text = serif[numberOfText]
            
            //ボイスを再生する
            if (girlVoice.isPlaying) {
                girlVoice.stop()
                girlVoice.play()
            } else {
                girlVoice.play()
            }
            
    
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backScreen.alpha = 0.7
        numberOfText = 0
        girlText.text = "タップしてスタート！"
        girlImage.image = UIImage(named: "girl_nomal")
        
        
    }
    
}

