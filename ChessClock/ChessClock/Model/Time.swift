
import Foundation

struct Time {
    var TotalSeconds : Int
    let increment : Int
    var hours: Int {
        get {
            return Int(self.TotalSeconds/3600)
        }
    }
    
    var minutes: Int {
        get {
            return Int((self.TotalSeconds % 3600)/60)
        }
    }
    var seconds: Int {
        get {
            return Int(self.TotalSeconds % 60)
        }
    }
    
    //boolean to prevent user from gaining time just by tappping!
    var alreadyTapped : Bool
    
    mutating func addIncrement() {
        self.TotalSeconds += self.increment
    }
    
    mutating func subtractTime() {
        self.TotalSeconds -= 1
    }
    
    //calculate and format the correct time in a readable way
    func calcString () -> String {
        let labelString = String(format: "%02d",self.hours) + ":" + String(format: "%02d",self.minutes) + ":" + String(format: "%02d",self.seconds)
        
        return labelString
    }


}

