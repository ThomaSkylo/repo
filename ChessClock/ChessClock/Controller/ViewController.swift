

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var Player1Label: UILabel!
    @IBOutlet weak var Player2Label: UILabel!
    @IBOutlet weak var UpLabel: UILabel!
    @IBOutlet weak var BottomLabel: UILabel!
    @IBOutlet weak var PauseBtn: UIButton!
    
    @IBOutlet weak var Player1View: UIView!
    @IBOutlet weak var Player2View: UIView!
    
    
    
    @IBAction func PauseBtnClicked(_ sender: UIButton) {
        if gameOver != true {
            timer.invalidate()
            PauseBtn.setImage(imageArr[0], for: .normal)
            PauseBtn.isEnabled = false
            Player1View.backgroundColor = UIColor.systemGray5
            Player2View.backgroundColor = UIColor.systemGray5
        }
    }
    
    var timer = Timer()
    var playerTime : Int?
    var increment : Int?
    var gameOver = false
    lazy var player1 = Time(TotalSeconds: playerTime ?? 1, increment: increment ?? 0, alreadyTapped: false)
    lazy var player2 = Time(TotalSeconds: playerTime ?? 1, increment: increment ?? 0, alreadyTapped: false)
    let imageArr : [UIImage] = [#imageLiteral(resourceName: "green_pause"),#imageLiteral(resourceName: "green_square")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PauseBtn.setImage(imageArr[1], for: .normal)
        //pause button not clickable until the game begins
        PauseBtn.isEnabled = false
        //turn labels upside down
        Player2Label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        UpLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        updateLabels()
    }
    
    //ensuring that the app will not switch to landscape mode during the game
    override open var shouldAutorotate: Bool {
           return false
       }
    
    //update all four labels with the correct time
    private func updateLabels() {
        Player1Label.text = player1.calcString()
        BottomLabel.text = player2.calcString()
        Player2Label.text = player2.calcString()
        UpLabel.text = player1.calcString()

    }
    
    
    @IBAction func Player1Taps(_ sender: UITapGestureRecognizer) {
        
        print ("Player 1 Taps!")
        if gameOver != true {
            PauseBtn.isEnabled = true
            PauseBtn.setImage(imageArr[0], for: .normal)
            Player1View.backgroundColor = UIColor.systemGray5
            Player2View.backgroundColor = UIColor.white
            player2.alreadyTapped = false
            timer.invalidate()
        }
        
        if self.player1.alreadyTapped == false && self.gameOver != true {
            self.player1.addIncrement()
            self.updateLabels()
            //prevent user from gaining time just by tapping again and again
            self.player1.alreadyTapped = true
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.player2.TotalSeconds > 0 && self.gameOver != true {
                self.player2.subtractTime()
                self.updateLabels()
            
            }
            else {
                //player two loses by time
                self.timer.invalidate()
                self.Player2View.backgroundColor = UIColor.systemRed
                self.gameOver = true
            }
      
    }
    }
        
    @IBAction func Player2Taps(_ sender: UITapGestureRecognizer) {
        
        
        print ("Player 2 Taps!")
        if gameOver != true{
            PauseBtn.isEnabled = true
            PauseBtn.setImage(imageArr[0], for: .normal)
            Player1View.backgroundColor = UIColor.white
            Player2View.backgroundColor = UIColor.systemGray5
            player1.alreadyTapped = false
            timer.invalidate()
        }
        
        if self.player2.alreadyTapped == false && self.gameOver != true {
            self.player2.addIncrement()
            self.updateLabels()
            self.player2.alreadyTapped = true
        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.player1.TotalSeconds > 0 && self.gameOver != true {
                self.player1.subtractTime()
                self.updateLabels()
            
            }
            else {
                //player one loses by time
                self.timer.invalidate()
                self.Player1View.backgroundColor = UIColor.systemRed
                self.gameOver = true 
            }
      
    }
    }
    
}

