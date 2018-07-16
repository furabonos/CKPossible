//
//  RAINpage.swift
//  CKPossible
//
//  Created by 엄태형 on 2018. 5. 16..
//  Copyright © 2018년 엄태형. All rights reserved.
//

import UIKit
import CoreLocation

class RAINpage: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var uvNum: UILabel!
    @IBOutlet weak var uvMsg: UILabel!
    @IBOutlet weak var rainAddr: UILabel!
    var locationManager: CLLocationManager = CLLocationManager()
    var manager: CLLocationManager = CLLocationManager()
    var allowGPS = false
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        
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
            print("locationManager Addr = \(locValue.latitude) \(locValue.longitude)")
            useAPI.latlonUV(la: locValue.latitude, lo: locValue.longitude, success: { (aa) -> (Void) in
                //날씨
                if aa.count == 1 {
                    self.present(Method.altMSG3(), animated: true, completion: nil)
                }else {
//                    print("aa1 = \(aa[0] as! String), aa2 = \(aa[1] as! String), aa3 = \(aa[2] as! String)")
                    self.uvMsg.text = "\(aa[0] as! String)"
                    self.uvNum.text = "현재 자외선 수치는 \(aa[2] as! String)시 기준 \(aa[1] as! String) 입니다."
                    useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                        self.rainAddr.text = "\(bb[0] as! String)"
                    })
                }
               
            })
        }//if authorized
    }//locationManager func declaration
    @IBAction func refreshBtn(_ sender: Any) {
        self.spinner.isHidden = false
        self.spinner.startAnimating()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
            print("callGPS Addr = \(locValue.latitude), \(locValue.longitude)")
            useAPI.latlonUV(la: locValue.latitude, lo: locValue.longitude, success: { (aa) -> (Void) in
                //날씨
                if aa.count == 1 {
                    self.present(Method.altMSG3(), animated: true, completion: nil)
                }else {
                    //                    print("aa1 = \(aa[0] as! String), aa2 = \(aa[1] as! String), aa3 = \(aa[2] as! String)")
                    self.uvMsg.text = "\(aa[0] as! String)"
                    self.uvNum.text = "현재 자외선 수치는 \(aa[2] as! String)시 기준 \(aa[1] as! String) 입니다."
                    useAPI.latlonLocation(la: locValue.latitude, lo: locValue.longitude, success: { (bb) -> (Void) in
                        self.rainAddr.text = "\(bb[0] as! String)"
                    })
                    self.spinner.isHidden = true
                }
                
            })
        }
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
