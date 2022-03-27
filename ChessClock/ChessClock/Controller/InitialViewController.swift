
import UIKit

class InitialViewController: UIViewController {
    

    var minutes = 1
    var increment = 0
    
    
    @IBOutlet weak var lblMinutes: UILabel!
    @IBOutlet weak var lblIncrement: UILabel!
    
    @IBAction func btnPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "clockSegue", sender: self)
        
    }
    
    @IBAction func minuteSliderChanged(_ sender: UISlider) {
        minutes = Int(sender.value)
        lblMinutes.text = "\(minutes)"
    }
    
    @IBAction func incrementSliderChanged(_ sender: UISlider) {
        increment = Int(sender.value)
        lblIncrement.text = "\(increment)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "clockSegue" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.playerTime = minutes * 60
            destinationVC.increment = increment
            
        }
    }

}
