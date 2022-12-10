//
//  ViewController.swift
//  catch-kenny
//
//  Created by Risetime on 10.12.2022.
//

import UIKit

class ViewController: UIViewController {
    let  highestScoreKey = "highestScore"
    let gameTime = 7
    //image for kenny1, this will be replaced with kenny2 and then kenny1 again for every second
    var kenny = UIImage(named: "kenny1")
    var kennyView = UIImageView()
    
    
    //kenny view starting position (0,0)
    var kennyPosX = 0
    var kennyPosY = 0
    
    var scoreCounter = 0
    var remainingTime = 20
    
    //UI Views for score and timer
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highestScoreLabel: UILabel!
    
    //timer for kenny's move
    var timer : Timer?
    
    override func viewDidLoad() {
        
        startGame()
        kennyView = UIImageView(image: kenny)
        highestScoreLabel.text = "Highest Score: \(UserDefaults.standard.value(forKey: highestScoreKey) ?? 0)"
        view.addSubview(kennyView)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func startGame() {
        remainingTime = gameTime
        kennyView.isUserInteractionEnabled = true
        let gestureDetector = UITapGestureRecognizer(target: self, action: #selector(onKennyClicked))
        kennyView.addGestureRecognizer(gestureDetector)
        timeLabel.text = "\(remainingTime)"
        scoreLabel.text = "Score: \(scoreCounter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(onTimerTicked), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerTicked() {
        decreaseRemainingTime()
        changeKennyViewsPosition()
        kennyView.isUserInteractionEnabled = true
        let gestureDetector = UITapGestureRecognizer(target: self, action: #selector(onKennyClicked))
        kennyView.addGestureRecognizer(gestureDetector)
        
    }
    
    
    func decreaseRemainingTime() {
        if(remainingTime == 0){
            onTimeOver()
            return
        } else {
            remainingTime -= 1
            timeLabel.text = "\(remainingTime)"
        }
    }
    
    func changeKennyViewsPosition() {
        let screenWidth = Int(view.frame.width)
        let screenHeight = Int(view.frame.height)
        kennyPosX = Int.random(in: 50...screenWidth - 50)
        kennyPosY = Int.random(in: 200...screenHeight - 100)
        kennyView.frame = CGRect(x: kennyPosX, y: kennyPosY, width: 75  , height: 75)
        view.addSubview(kennyView)
    }
    
    @objc func onKennyClicked() {
        print("Kenny Clicked")
        scoreCounter += 1
        scoreLabel.text = "Score: \(scoreCounter)"
        
    }
    
    func onTimeOver() {
        let highestScore = (UserDefaults.standard.value(forKey: highestScoreKey) ?? 0) as! Int
        if(highestScore < scoreCounter){
            onRecordBreak()
        }
          
        
        timer?.invalidate()
        let alert = UIAlertController(title: "Time Over", message: "Want to try again?", preferredStyle: UIAlertController.Style.alert)
        let tryAgainButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){
            (UIAlertAction) in
            self.restartGame()}
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default){
            (UIAlertAction) in
            self.cancelGame()}
            alert.addAction(tryAgainButton)
            alert.addAction(cancelButton)
            
            self.present(alert, animated: true)
            
        }
        
    
    func onRecordBreak() {
        let alert = UIAlertController(title: "Congratulations", message: "You have break the record", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default){(UIAlertAction) in self.cancelGame()})
        self.present(alert, animated: true)
        UserDefaults.standard.set(scoreCounter, forKey: highestScoreKey)
        highestScoreLabel.text = "Highest Score: \(UserDefaults.standard.value(forKey: highestScoreKey) ?? 0)"
    }
    func restartGame() {
        remainingTime = gameTime
        scoreCounter = 0
        timeLabel.text = "\(remainingTime)"
        scoreLabel.text = "\(scoreCounter)"
        timer?.invalidate()
        startGame()
    }
    
    func cancelGame() {
        timeLabel.isUserInteractionEnabled = true
        timeLabel.text = "Try Again"
        let tryAgainTap = UITapGestureRecognizer(target: self, action: #selector(tryAgain))
        timeLabel.addGestureRecognizer(tryAgainTap)
                                                     
        scoreCounter = 0
        scoreLabel.text = "Score: "
        remainingTime = 0
        timer?.invalidate()
    }
    
    @objc func tryAgain() {
        restartGame()
    }
        /*func changeKennyView() {
         if(selectedKennyIndex == 0){
         selectedKennyIndex = 1
         kenny = UIImage(named: kennyViewList[selectedKennyIndex])
         } else if(selectedKennyIndex == 1){
         selectedKennyIndex = 0
         kenny = UIImage(named: kennyViewList[selectedKennyIndex])
         }
         
         }*/
    }


