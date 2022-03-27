
import Foundation


protocol CoinManagerDelegate {
    func didUpdateCoin (coin: CoinData)
    func didFailWithError(error: Error)
}

struct CoinManager  {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "01073E48-D8C1-4759-87B9-8F3E8346415A"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?

    func getCoinPrice(for currency: String){
        let urlString = "\(self.baseURL)\(currency)?apikey=\(self.apiKey)"
        self.performRequest(with: urlString)
    }
    
    
    func handle(data:Data?, response:URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            parseJSON(coinData: safeData)
            //print(dataString!)
        }
    }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            task.resume()
        }
        
    }
    
    func parseJSON (coinData : Data){
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            print(type(of: decodedData))
            self.delegate?.didUpdateCoin(coin: decodedData)
        }
        catch {
            //print(error)
            self.delegate?.didFailWithError(error: error)
        }
            
    }
    
    
}
