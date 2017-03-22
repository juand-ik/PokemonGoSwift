//
//  ViewController.swift
//  PokemonGo
//
//  Created by Juan de Dios Torres on 21/03/17.
//  Copyright © 2017 Juan de Dios Torres. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate
{

    @IBOutlet weak var mapView: MKMapView!
    
    let mapDistance : CLLocationDistance = 300
    
    var manager = CLLocationManager()
    var updateCount = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.manager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            print("ok, listo para los pokemon")
            self.mapView.showsUserLocation = true
            self.manager.startUpdatingLocation()
        }
        else
        {
            self.manager.requestWhenInUseAuthorization()
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    //MARK: Core Location MAnager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        //print("Actualizando posición...")
        if updateCount < 4
        {
            if (self.manager.location?.coordinate) != nil
            {
                let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, mapDistance, mapDistance)
                self.mapView.setRegion(region, animated: true)
                updateCount += 1
            }
        }
        else
        {
            self.manager.stopUpdatingLocation()
        }
    }
    @IBAction func updateUserLocation(_ sender: UIButton)
    {
        if (self.manager.location?.coordinate) != nil
        {
            let region = MKCoordinateRegionMakeWithDistance(self.manager.location!.coordinate, mapDistance, mapDistance)
            self.mapView.setRegion(region, animated: true)
        }
    }

}

