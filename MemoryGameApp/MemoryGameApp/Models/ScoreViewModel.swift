

import Foundation
import CoreLocation


class ScoreViewModel : NSObject ,NSCoding{
   
    var playerTime : String = ""
    var playerMoves : Int = 0
    var playerName : String = ""
    var lat : Double = 0.0
    var lng  : Double = 0.0
    //var location : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override init() {
        self.playerTime  = ""
        self.playerMoves  = 0
        self.playerName  = ""
        self.lat = 0.0
        self.lng = 0.0
      //  self.location = CLLocationCoordinate2D()
      
    }
    

    func encode(with aCoder: NSCoder) {
        aCoder.encode(playerTime, forKey: "playerTime")
        aCoder.encode(playerMoves, forKey: "playerMoves")
        aCoder.encode(lat, forKey: "lat")
        aCoder.encode(lng, forKey: "lng")
        //aCoder.encode(self.location, forKey: "location")
        aCoder.encode(self.playerName, forKey: "playerName")
       
    }

    required convenience init(coder aDecoder: NSCoder) {
        self.init()
        playerTime = aDecoder.decodeObject(forKey: "playerTime") as? String ?? ""
        playerMoves = aDecoder.decodeInteger(forKey: "playerMoves")
        playerName = aDecoder.decodeObject(forKey: "playerName") as? String ?? ""
        lat = aDecoder.decodeDouble(forKey: "lat")
        lng = aDecoder.decodeDouble(forKey: "lng")
       // location = aDecoder.decodeObject(forKey: "location") as? CLLocationCoordinate2D ?? CLLocationCoordinate2D()
        
    }
}
