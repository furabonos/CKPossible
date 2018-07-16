//
//  ViewController.swift
//  CKPossible
//
//  Created by 엄태형 on 2017. 7. 8..
//  Copyright © 2017년 엄태형. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var clothsView8: UIImageView!
    @IBOutlet weak var clothsView7: UIImageView!
    @IBOutlet weak var clothsView6: UIImageView!
    @IBOutlet weak var clothsView5: UIImageView!
    @IBOutlet weak var clothsView4: UIImageView!
    @IBOutlet weak var clothsView3: UIImageView!
    @IBOutlet weak var clothsView2: UIImageView!
    @IBOutlet weak var clothsView1: UIImageView!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherTemp: UILabel!
    @IBOutlet weak var placeText: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var ondo:Int = 0
    var searchWord = "" //검색어
    var viewArr: [UIImageView] = []
    var geoInfo = ""
    var weatherInfo = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.stopAnimating()
        self.indicator.isHidden = true
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func searhbtn(_ sender: Any) {
        searchWord = placeText.text! //지역명 입력한 걸 뽑음
        if searchWord == "" || searchWord.count == 1  {
            self.present(Method.altMSG(), animated: true, completion: nil)
        }else{
            if searchWord.validateKor() == true {
                self.indicator.startAnimating()
                self.indicator.isHidden = false
                useAPI.Sigungu(word: searchWord, success: { (geoInfo) -> (Void) in
                    useAPI.requestWeatherWord(s: geoInfo[0], g: geoInfo[1], d: geoInfo[2], le: geoInfo[3], lo: geoInfo[4], success: { (weatherInfo) -> (Void) in
                        self.weatherTemp.text = weatherInfo[0] as! String+"℃"
                        var s = weatherInfo[0] as! String
                        var realOndo = Int(s)
                        self.weatherIcon.image = Method.makeIcon(code: weatherInfo[1] as! String, time: weatherInfo[2] as! Int)
                        self.viewArr = [self.clothsView1,self.clothsView2,self.clothsView3,self.clothsView4,self.clothsView5,self.clothsView6,self.clothsView7,self.clothsView8]
                        for i in 0..<Method.selectCloth(owndo: realOndo!).count{
                            self.viewArr[i].image = Method.selectCloth(owndo: realOndo!)[i]
                        }
                    })
                    self.indicator.isHidden = true
                    self.indicator.stopAnimating()
                    self.dismissKeyboard()
                })//입력한 지명으로 api호출
            }else{
                self.present(Method.altMSG2(), animated: true, completion: nil)
            }
        }
    }
    
}

