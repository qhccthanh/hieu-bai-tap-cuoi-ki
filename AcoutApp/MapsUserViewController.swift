//
//  PlayMusicViewController.swift
//  AcoutApp
//
//  Created by James on 9/12/18.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapsUserViewController: UIViewController {
    
    let mapView: GMSMapView = {
     let mapView = GMSMapView()
        
     return mapView
    }()
    
    let locationManager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupContrains()
        
        mapView.isMyLocationEnabled = true
        locationManager.requestWhenInUseAuthorization()
        locationManager.stopUpdatingLocation()
        locationManager.delegate = self as! CLLocationManagerDelegate

        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupView() {
        self.mapView.addSubview(mapView)
        
    }
    
    fileprivate func setupContrains() {
        self.mapView.snp.makeConstraints {(make) in
            make.edges.equalToSuperview()
        }
    }

}
extension MapsUserViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {return}
        let cameraPosition = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 20)
        mapView.animate(to: cameraPosition)
        
        FirebaseData.shared.userRef.child("location").setValue(["latitude": location.coordinate.latitude, "longtitude": location.coordinate.longitude])
        
    }
}
