//
//  SelectOptionViewController.swift
//  MemoryGameApp
//
//  Created by apple on 7/3/21.
//

import UIKit
import CoreLocation

class SelectOptionViewController: UIViewController,CLLocationManagerDelegate ,UITextFieldDelegate{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var txtfName: UITextField!
    
    let locationManager = CLLocationManager()
    var location = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtfName.delegate = self
        self.configureLocation()
      
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.lblName.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.txtfName.endEditing(true)
        return false
    }
    
    func configureLocation(){
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        if let location = locations.last{
            self.location = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    
        }
    }
    
    @IBAction func actionPlay(_ sender: Any) {
        
        if(self.txtfName.text == ""){
            self.lblName.isHidden = false
        }
        else{
            self.lblName.isHidden = true
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            vc.playerLocation = self.location
            vc.playerName = self.txtfName.text ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
      
    }
    
    @IBAction func actionTopTen(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TopTenScoreViewController") as! TopTenScoreViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
