//
//  TopTenScoreViewController.swift
//  MemoryGameApp
//
//  Created by apple on 7/3/21.
//

import UIKit
import MapKit
import CoreLocation

class TopTenScoreViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate,UITableViewDataSource , UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapKit: MKMapView!
    let locationManager = CLLocationManager()
    var storage = localStorage()
    var records = [ScoreViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLocation()
        self.loadScore()

    }
    
    @IBAction func actionBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func loadScore(){
        if(storage.isRecord){
           self.records = storage.scoreRecords
           self.tableView.reloadData()
            self.records = self.records.sorted(by: {$1.playerMoves > $0.playerMoves})
            for record in 0 ..< self.records.count{
                let annotation = MKPointAnnotation()
                let center = CLLocationCoordinate2D(latitude: self.records[record].lat, longitude: self.records[record].lng)
                annotation.coordinate = center
                annotation.title = self.records[record].playerName
                mapKit.addAnnotation(annotation)
                if(record == 0){
                    let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
                    self.mapKit.setRegion(region, animated: true)
                }
             
            }
         }
    }
    
    func configureLocation(){
        self.locationManager.requestAlwaysAuthorization()


            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

        mapKit.delegate = self
        mapKit.mapType = .standard
        mapKit.isZoomEnabled = true
        mapKit.isScrollEnabled = true

            if let coor = mapKit.userLocation.location?.coordinate{
                mapKit.setCenter(coor, animated: true)
            }    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        
        if let location = locations.last{
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
           
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as! RecordTableViewCell
        cell.lblName.text = self.records[indexPath.row].playerName
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let center = CLLocationCoordinate2D(latitude: self.records[indexPath.row].lat, longitude: self.records[indexPath.row].lng)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3))
        self.mapKit.setRegion(region, animated: true)
    }
    



}
