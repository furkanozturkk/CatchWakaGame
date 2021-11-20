//
//  ViewController.swift
//  CatchWakaGame
//
//  Created by Furkan Öztürk on 19.11.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    let waka = UIImageView()
    var timer = Timer()
    var time = 0
    var point = 0
    var frameWidth = 0
    var frameHeight = 0
    var speed = 0.0
    var wakaWidth = 0
    var wakaHeight = 0
    var difficultly = 0
    var calcPoint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    @objc func initialize(){
        difficultly=20
        wakaWidth=100
        wakaHeight=100
        frameWidth = Int(view.frame.size.width)
        frameHeight = Int(view.frame.size.height)
        time = 10
        speed = 0.9
        point=0
        timer=Timer.scheduledTimer(timeInterval: speed, target: self, selector: #selector(moveWaka), userInfo: nil, repeats: true)
        scoreLabel.text = "Skor: \(point)"
        timeLabel.text = String(time)
        let bs = UserDefaults.standard.integer(forKey: "bestScore")
        highscoreLabel.text = "En Yüksek Puan: \(String(bs))"
        createWaka()
    }
    
    func createWaka(){
        waka.frame = CGRect(x:(frameWidth/2)-(wakaWidth/2), y: (frameHeight/2)-(wakaWidth), width: wakaWidth, height: wakaHeight)
        waka.image = UIImage(named: "wakaavatar")
        waka.isUserInteractionEnabled = true
        let gestureRec = UITapGestureRecognizer(target: self, action: #selector(addPoint))
        waka.addGestureRecognizer(gestureRec)
        view.addSubview(waka)
    }
    
    @objc func moveWaka(){
        
        //Set default position
        let wakaWidthPos = Int.random(in: 0 ..< Int(frameWidth)-wakaWidth)
        let wakaHeightPos = Int.random(in: wakaHeight+50 ..< Int(frameHeight)-(wakaHeight+80))
        waka.frame = CGRect(x: wakaWidthPos, y: wakaHeightPos, width: wakaWidth, height: wakaHeight)
        
        time -= 1;
        timeLabel.text = String(time)
        
        if time == 0{
            timer.invalidate()
            
            //Save High Score in Memory
            let bs = UserDefaults.standard.integer(forKey: "bestScore")
            if point > bs{
                UserDefaults.standard.set(point, forKey: "bestScore")
                highscoreLabel.text = "En Yüksek Puan: \(String(bs))"
            }
            
            
            //Alert
            let alert = UIAlertController(title: "Zaman Bitti!", message: "Tekrar Oynamak İster misin?", preferredStyle: UIAlertController.Style.alert)
            let alertReplayAction = UIAlertAction(title: "Tekrar Oyna", style: UIAlertAction.Style.default) { UIAlertAction in
                self.initialize()
            }
            alert.addAction(alertReplayAction)
            self.present(alert, animated: true, completion: nil)
            
            
        }
    }
    
    @objc func addPoint(){
        
        point += 1
        calcPoint += 1
        if calcPoint % difficultly == 0{
            calcPoint=0;
            difficultly += 2
            time += 10
            if speed >= 0.05{
                speed -= 0.1
            }
            if(wakaWidth >= 10 && wakaHeight >= 10 ){
                wakaWidth -= 5
                wakaHeight -= 5
            }
            
        }
        
        scoreLabel.text = "Skor: \(point)"
    }


}

