//
//  STORMpage.swift
//  CKPossible
//
//  Created by 엄태형 on 2018. 5. 16..
//  Copyright © 2018년 엄태형. All rights reserved.
//

import UIKit
import CoreLocation

class STORMpage: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var stormAddr: UILabel!
    var locationManager: CLLocationManager = CLLocationManager()
    var manager: CLLocationManager = CLLocationManager()
    var allowGPS = false
    var bb = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            allowGPS = true
            print("yes allow1 = \(allowGPS)")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("locationManager Addr Storm = \(locValue.latitude) \(locValue.longitude)")
            useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                print("storm where  = \(bb[0] as! String)")
                self.stormAddr.text = bb[0] as! String
            })
        }//if authorized
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
