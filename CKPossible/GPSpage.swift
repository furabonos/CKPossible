//
//  GPSpage.swift
//  CKPossible
//
//  Created by 엄태형 on 2018. 1. 9..
//  Copyright © 2018년 엄태형. All rights reserved.
//

import UIKit
import CoreLocation

class GPSpage: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var addrLable: UILabel!
    @IBOutlet weak var addrLable2: UILabel!
    @IBOutlet weak var clothsView1: UIImageView!
    @IBOutlet weak var clothsView2: UIImageView!
    @IBOutlet weak var clothsView3: UIImageView!
    @IBOutlet weak var clothsView4: UIImageView!
    @IBOutlet weak var clothsView5: UIImageView!
    @IBOutlet weak var clothsView6: UIImageView!
    @IBOutlet weak var clothsView7: UIImageView!
    @IBOutlet weak var clothsView8: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    var lat: String = ""
    var lon: String = ""
    var manager: CLLocationManager = CLLocationManager()
    var aa = ""
    var bb = String()
    var viewArr: [UIImageView] = []
    var exArr: [CLLocation] = []
    var newLat = Double()
    var newLon = Double()
    var allowGPS = false
    
    override func viewDidLoad() {// Ask for Authorisation from the User.
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshBtn(_ sender: Any) {
        if allowGPS == true {
            print("yes allow2 = \(allowGPS)")
            self.spinner.isHidden = false
            self.spinner.startAnimating()
            /*newLat = callGPS()[0]//40.091990
             newLon = callGPS()[1]//-98.413162
             */
            //
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self as? CLLocationManagerDelegate
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
                let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
                print("callGPS Addr = \(locValue.latitude), \(locValue.longitude)")
                useAPI.latlonWeather(la: locValue.latitude, lo: locValue.longitude, success: { (aa) -> (Void) in
                    if aa.count == 1 {
                        self.spinner.isHidden = true
                        self.present(Method.altMSG3(), animated: true, completion: nil)
                        print("success=\(aa)")
                    }else {
                        self.weatherTemp.text = aa[0] as! String+"℃"
                        self.weatherIcon.image = Method.makeIcon(code: aa[1] as! String, time: aa[2] as! Int)
                        self.viewArr = [self.clothsView1,self.clothsView2,self.clothsView3,self.clothsView4,self.clothsView5,self.clothsView6,self.clothsView7,self.clothsView8]
                        var ondo = aa[0] as! String
                        var realOndo = Int(ondo)!
                        for i in 0..<Method.selectCloth(owndo: realOndo).count{
                            self.viewArr[i].image = Method.selectCloth(owndo: realOndo)[i]
                        }
                        useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                            self.addrLable.text = "\(bb[0] as! String)의 날씨에"
                            self.addrLable2.text = "알맞은 옷차림은..."
                        })
                        self.spinner.isHidden = true
                        print("success=\(aa)")
                    }
                })
            }
        }else {
            print("not allow")
        }
        
        //
        /*useAPI.latlonWeather(la: newLat, lo: newLon, success: { (aa) -> (Void) in
            if aa.count == 1 {
                self.spinner.isHidden = true
                self.present(Method.altMSG3(), animated: true, completion: nil)
                print("success=\(aa)")
            }else {
                self.weatherTemp.text = aa[0] as! String+"℃"
                self.weatherIcon.image = Method.makeIcon(code: aa[1] as! String, time: aa[2] as! Int)
                self.viewArr = [self.clothsView1,self.clothsView2,self.clothsView3,self.clothsView4,self.clothsView5,self.clothsView6,self.clothsView7,self.clothsView8]
                var ondo = aa[0] as! String
                var realOndo = Int(ondo)!
                for i in 0..<Method.selectCloth(owndo: realOndo).count{
                    self.viewArr[i].image = Method.selectCloth(owndo: realOndo)[i]
                }
                useAPI.latlonLocation(la: self.newLat, lo: self.newLon, success: { (bb) -> (Void) in
                    self.addrLable.text = "\(bb[0] as! String)의 날씨에"
                    self.addrLable2.text = "알맞은 옷차림은..."
                })
                self.spinner.isHidden = true
                print("success=\(aa)")
            }
        })
 */
        
    }
    
    func callGPS() -> [Double] {
        var arr = Array<Double>()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            var locValue:CLLocationCoordinate2D = manager.location!.coordinate
            print("callGPS Addr = \(locValue.latitude), \(locValue.longitude)")
            arr = [locValue.latitude,locValue.longitude]
        }
        return arr
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            allowGPS = true
            print("yes allow1 = \(allowGPS)")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("locationManager Addr = \(locValue.latitude) \(locValue.longitude)")
            useAPI.latlonWeather(la: locValue.latitude, lo: locValue.longitude, success: { (aa) -> (Void) in
                if aa.count == 1 {
                    self.spinner.isHidden = true
                    self.present(Method.altMSG3(), animated: true, completion: nil)
                    print("aa=\(aa[0])")
                }else {
                    self.spinner.startAnimating()
                    self.weatherTemp.text = aa[0] as! String+"℃"
                    self.weatherIcon.image = Method.makeIcon(code: aa[1] as! String, time: aa[2] as! Int)
                    self.viewArr = [self.clothsView1,self.clothsView2,self.clothsView3,self.clothsView4,self.clothsView5,self.clothsView6,self.clothsView7,self.clothsView8]
                    var ondo = aa[0] as! String
                    var realOndo = Int(ondo)!
                    print("real=\(realOndo)")
                    print("ondo=\(aa[0])")
                    for i in 0..<Method.selectCloth(owndo: realOndo).count{
                        self.viewArr[i].image = Method.selectCloth(owndo: realOndo)[i]
                    }
                    useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                        self.addrLable.text = "\(bb[0] as! String)의 날씨에"
                        self.addrLable2.text = "알맞은 옷차림은..."
                    })
                    self.spinner.isHidden = true
                    print("success=\(aa)")
                }
            })
        }//if authorized
    }//locationManager func declaration
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

