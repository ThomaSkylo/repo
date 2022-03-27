
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
    var coinManager = CoinManager()
   
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getCoinPrice(for: coinManager.currencyArray[row])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }


}

extension ViewController: CoinManagerDelegate {
    func didUpdateCoin(coin: CoinData) {
        DispatchQueue.main.async {
        self.bitcoinLabel.text = String(format: "%.2f", coin.rate)
        }
    }
    func didFailWithError(error: Error) {
            print(error)
        }
}

