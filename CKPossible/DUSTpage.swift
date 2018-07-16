//
//  DUSTpage.swift
//  CKPossible
//
//  Created by 엄태형 on 2018. 1. 17..
//  Copyright © 2018년 엄태형. All rights reserved.
//

import UIKit
import CoreLocation

class STORMpage: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var manager: CLLocationManager = CLLocationManager()
    var aa: [Any] = []
    var bb = String()
    var newLat = Double()
    var newLon = Double()
    var allowGPS = false
    var urll = ""

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var dustIcon: UIImageView!
    @IBOutlet weak var addrLable: UILabel!
    @IBOutlet weak var dustMsg: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        
        // Do any additional setup after loading the view.
        //self.locationManager.requestAlwaysAuthorization()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func callGPS() -> [Double] {
        var arr = Array<Double>()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            var locValue:CLLocationCoordinate2D = manager.location!.coordinate
            print("locations = \(locValue.latitude), \(locValue.longitude)")
            arr = [locValue.latitude,locValue.longitude]
        }
        return arr
    }
    @IBAction func refreshBtn(_ sender: Any) {
        if allowGPS == true {
            print("yse allow4 = \(allowGPS)")
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            // Do any additional setup after loading the view.
            // For use in foreground
            //newLat = callGPS()[0]
            //newLon = callGPS()[1]
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self as? CLLocationManagerDelegate
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                var locValue:CLLocationCoordinate2D = manager.location!.coordinate
                print("locations = \(locValue.latitude), \(locValue.longitude)")
                useAPI.latlonUv(la: locValue.latitude, lo: locValue.longitude, success: { (aa) -> (Void) in
                    if aa.count == 1 {
                        self.spinner.isHidden = true
                        self.present(Method.altMSG3(), animated: true, completion: nil)
                        print("aa=\(aa[0])")
                    }else {
                        useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                            print("addr=\(bb[0] as! String)")
                            self.addrLable.text = bb[0] as! String
                        })
                        self.dustIcon.image = Method.selectDust(msg: aa[0] as! String)
                        self.dustMsg.text = Method.selectDustMsg(msg: aa[0] as! String)
                        self.spinner.isHidden = true
                        print("aa!=\(aa[0])")
                    }
                })
            }
        }else {
            print("not allow2")
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            allowGPS = true
            print("yes allow3 = \(allowGPS)")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("locationsㄴㄴㄴㄴㄴㄴㄴㄴㄴ = \(locValue.latitude) \(locValue.longitude)")
            useAPI.latlonUv(la: locValue.latitude, lo: locValue.longitude, success: { (aa) -> (Void) in
                if aa.count == 1 {
                    self.spinner.isHidden = true
                    self.present(Method.altMSG3(), animated: true, completion: nil)
                    print("aa=\(aa[0])")
                }else {
                    useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                        print("addr=\(bb[0] as! String)")
                        self.addrLable.text = bb[0] as! String
                        
                    })
                    self.dustIcon.image = Method.selectDust(msg: aa[0] as! String)
                    self.dustMsg.text = Method.selectDustMsg(msg: aa[0] as! String)
                    self.spinner.isHidden = true
                    print("aa!=\(aa[0])")
                }
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
