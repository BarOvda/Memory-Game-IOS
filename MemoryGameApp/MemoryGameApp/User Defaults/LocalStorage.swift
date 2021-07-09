//
//  LocalStorage.swift
//  MemoryGameApp
//
//  Created by apple on 7/3/21.
//

import Foundation

class localStorage {
    var scoreRecords:[ScoreViewModel]! {
        set {
            do{ let data = try NSKeyedArchiver.archivedData(withRootObject: newValue!, requiringSecureCoding: false)
                UserDefaults.standard.set(data, forKey: "scoreRecords")
                UserDefaults.standard.synchronize()
            }
            catch{
                print("error")
            }
           
        }
        get {
            if let data = UserDefaults.standard.data(forKey: "scoreRecords") {
                do{
                    let records = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [ScoreViewModel]
                     return records
                }
                catch{
                    print("error")
                    return nil
                }
            }else {
                return nil
            }
            
        }
    }
    
    var isRecord:Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: "isRecord")
            UserDefaults.standard.synchronize()
        }
        get {
            return  UserDefaults.standard.bool(forKey: "isRecord")
        }
    }

}
