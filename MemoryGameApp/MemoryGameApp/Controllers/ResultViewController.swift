
import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var lblScore: UILabel!
    var totalSeconds : Float = 0.0
    var moves = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblScore.text = "You completed the game in \(timeFormatted(self.totalSeconds)) and in \(self.moves) Moves"
    }
    @IBAction func actionMenu(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    func timeFormatted(_ totalSeconds: Float) -> String {
        let seconds: Int = Int(totalSeconds) % 60
        let prodMinutes = Int(totalSeconds) / 60 % 60
        let hours = Int(totalSeconds) / 3600
        if(hours > 0){
            return String(format: "%02d:%02d:%02d",hours, prodMinutes,seconds)
        }
        else{
            return String(format: "%02d:%02d", prodMinutes,seconds)
        }
       
    }

}
