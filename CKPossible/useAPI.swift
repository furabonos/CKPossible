//
//  useAPI.swift
//  CKPossible
//
//  Created by 엄태형 on 2017. 11. 13..
//  Copyright © 2017년 엄태형. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class useAPI: NSObject {
    
    static func Sigungu(word: String, success: @escaping ((Array<String>) -> (Void))) {
        var si = "" //시
        var gu = "" //구
        var dong = "" //동
        var lat:String = "" //위도
        var lon:String = "" //경도
        var infoArr = Array<String>()
        let appKey = "744317bb-0888-4bc2-a53b-63d5beb3d5d3"
        let placeURL = "https://api2.sktelecom.com/tmap/pois"
        
        
        var headers2 = [String: String]()
        headers2.updateValue(appKey, forKey: "appKey")
        
        var parameters2 = [String: String]()
        parameters2.updateValue("1", forKey: "version")
        parameters2.updateValue(word, forKey: "searchKeyword")
        parameters2.updateValue("1", forKey: "count")
        
        Alamofire.request(placeURL, method: .get, parameters: parameters2, headers: headers2)
            .validate().responseData{ response in
                switch response.result{
                case .success:
                    if let data = response.data {
                        let json1 = JSON(data)
                        si = json1["searchPoiInfo"]["pois"]["poi"][0]["upperAddrName"].string!//시
                        gu = json1["searchPoiInfo"]["pois"]["poi"][0]["middleAddrName"].string!//구
                        dong = json1["searchPoiInfo"]["pois"]["poi"][0]["lowerAddrName"].string!//동
                        lat = json1["searchPoiInfo"]["pois"]["poi"][0]["frontLat"].string!//위도
                        lon = json1["searchPoiInfo"]["pois"]["poi"][0]["frontLon"].string!//경도
                        infoArr = [si,gu,dong,lat,lon]
                        print(infoArr)
                        success(infoArr)
 
//                        print(json1)
//                        print(json1["searchPoiInfo"]["pois"]["poi"][0]["middleAddrName"])
//                        print(json1["searchPoiInfo"]["pois"]["poi"][0]["lowerAddrName"])
//                        print(json1["searchPoiInfo"]["pois"]["poi"][0]["upperAddrName"])
                    }
                case .failure:
                    let altMSG = "self.present(Method.altMSG2(), animated: true, completion: nil)"
                    print("error : \(response.error!)")
                    altMSG
                }
        }
    }
    static func requestWeatherWord(s: String, g: String, d: String, le: String, lo: String, success: @escaping ((Array<Any>) -> (Void))) {
        
        let weatherURL = "https://api2.sktelecom.com/weather/current/hourly"
        let appKey = "3c848d81-f425-4f71-8b56-03f30d59f64f"
        
        var x:String = ""//code변수
        var y:String = ""//온도변수
        var z:String = ""
        var a:Int = 0//시간변수
        var ondo:Int = 0
        var iconName = ""
        var testing:String = ""
        var weatherArr: [Any] = []
        
        var headers = [String: String]()
        headers.updateValue(appKey, forKey: "appKey")
        
        var parameters = [String: String]()
        parameters.updateValue("1", forKey: "version")
        parameters.updateValue(s, forKey: "city")
        parameters.updateValue(g, forKey: "county")
        parameters.updateValue(d, forKey: "village")
        
        
        Alamofire.request(weatherURL, method: .get, parameters: parameters, headers: headers)
            .validate().responseData{ response in
                switch response.result{
                case .success:
                    if let data = response.data {
                        var json = JSON(data)
                        //print(json)
                        
                        let hourly = json["weather"]["hourly"][0]
                        if hourly.exists(){
                            //hourly가 없을때
                            //print(hourly["sky"]["code"].stringValue)
                            x = hourly["sky"]["code"].stringValue //날씨code
                            y = hourly["temperature"]["tc"].stringValue //온도
                            z = hourly["timeRelease"].stringValue//검색시간
                            let start = z.index(z.startIndex, offsetBy: 11)
                            let end = z.index(z.endIndex, offsetBy: -6)
                            let range = start..<end
                           // print(z[range])//검색시간
                            //print("검색시간=\(z)")
                            a = Int(z[range])!
                            //print("time=\(z)")
                            if y.StringCount() == 5 {
                                testing = (y.substring(to: y.index(y.startIndex, offsetBy: 2)))
                            }else if y.StringCount() == 4 {
                                testing = (y.substring(to: y.index(y.startIndex, offsetBy: 1)))
                            }else if y.StringCount() >= 6 {
                                testing = (y.substring(to: y.index(y.startIndex, offsetBy: 3)))
                            }
                            print("testing=\(testing)")
                            weatherArr = [testing,x,a]
                            success(weatherArr)
                        }else{
                            let altMSG = "self.present(Method.altMSG2(), animated: true, completion: nil)"
                            altMSG
                        }
                    }
                case .failure:
                    let altMSG = "self.present(Method.altMSG2(), animated: true, completion: nil)"
                    altMSG
                    print("error : \(response.error!)")
                    
                }
        }
    }
    
    static func latlonWeather(la: Double, lo: Double, success: @escaping ((Array<Any>) -> (Void))) {
        var x:String = ""//code변수
        var y:String = ""//온도변수
        var z:String = ""
        var t:String = ""//날씨텍스트 ex)흐림,맑음..
        var ondo:Int = 0
        var iconName = ""
        var testing:String = ""
        var a:Int = 0//시간변수
        
        //let weatherURL = "http://apis.skplanetx.com/weather/current/hourly?&lat=37.785834&lon=-122.406417"
        let weatherURL = "https://api2.sktelecom.com/weather/current/hourly?&lat=\(la)&lon=\(lo)"
        let appKey = "3c848d81-f425-4f71-8b56-03f30d59f64f"
        
        var weatherArr: [Any] = []
        var headers = [String: String]()
        //headers.updateValue(TDCProjectKey, forKey: "TDCProjectKey")
        headers.updateValue(appKey, forKey: "appKey")
        
        var parameters = [String: String]()
        parameters.updateValue("1", forKey: "version")
        
        Alamofire.request(weatherURL, method: .get, parameters: parameters, headers: headers)
            .validate().responseData{ response in
                switch response.result{
                case .success:
                    if let data = response.data {
                        print("success")
                        var json = JSON(data)
                        print(json)
                        let hourly = json["weather"]["hourly"][0]
                        if hourly.exists() {
                            x = hourly["sky"]["code"].stringValue //날씨code
                            y = hourly["temperature"]["tc"].stringValue //온도
                            z = hourly["timeRelease"].stringValue//검색시간
                            t = hourly["sky"]["name"].stringValue //날씨code
                            let start = z.index(z.startIndex, offsetBy: 11)
                            let end = z.index(z.endIndex, offsetBy: -6)
                            let range = start..<end
                            // print(z[range])//검색시간
                            // print(z)
                            a = Int(z[range])!
                            
                            if y.StringCount() == 5 {
                                testing = (y.substring(to: y.index(y.startIndex, offsetBy: 2)))
                            }else if y.StringCount() == 4 {
                                testing = (y.substring(to: y.index(y.startIndex, offsetBy: 1)))
                            }else if y.StringCount() >= 6 {
                                testing = (y.substring(to: y.index(y.startIndex, offsetBy: 3)))
                            }
                            print("testing=\(testing)")
                            weatherArr = [testing,x,a,t]
                            success(weatherArr)
                        }else {
                            weatherArr = ["aa"]
                            success(weatherArr)
                        }
                    }
                case .failure:
                    print("error : \(response.error!)")
                    
                }
        }
    }
    
    static func latlonLocation(la: Double, lo: Double, success: @escaping ((Array<Any>) -> (Void))) {
        //let weatherURL = "http://apis.skplanetx.com/weather/current/hourly?version=1&lat=\(la)&lon=\(lo)"
        let locationURL = "https://apis.sktelecom.com/v1/zonepoi/pois?latitude=\(la)&longitude=\(lo)&radiusCode=3"
        //let locationURL = "https://apis.sktelecom.com/v1/zonepoi/pois?latitude=37.459654&longitude=126.735607&radiusCode=3"
        
        //let appKey = "9862dddd-f683-49fa-b461-ab20a8f67a11"
        //let appKey = "b0e67f3c-7861-3c4c-a89e-62cbccd6b6a7"
        let TDCProjectKey = "3ee699ac-2779-4e94-870d-2a875f8738ef"
        var locationArr: [Any] = []
        var headers = [String: String]()
        headers.updateValue(TDCProjectKey, forKey: "TDCProjectKey")
        
        Alamofire.request(locationURL, method: .get, headers: headers)
            .validate().responseData{ response in
                switch response.result{
                case .success:
                    if let data = response.data {
                        print("success")
                        var json = JSON(data)
                        //print(json)
                        var addrInfo = json["results"][0]["addr"].stringValue
                        locationArr = [addrInfo]
                        success(locationArr)
                    }
                case .failure:
                    print("error : \(response.error!)")
                    
                }
        }
    }
    static func latlonUV(la: Double, lo: Double, success: @escaping ((Array<Any>) -> (Void))) {
        var x:String = ""//
        var y:String = ""//
        var z:String = ""//stormYn
        var a:String = ""//time
        let rainURL = "https://api2.sktelecom.com/weather/index/uv?lat=\(la)&lon=\(lo)"
//        let rainURL = "https://api2.sktelecom.com/weather/index/uv?lat=37.459432&lon=126.735607"
        let appKey = "3c848d81-f425-4f71-8b56-03f30d59f64f"
        
        var uvArr: [Any] = []
        var headers = [String: String]()
        //headers.updateValue(TDCProjectKey, forKey: "TDCProjectKey")
        headers.updateValue(appKey, forKey: "appKey")
        
        var parameters = [String: String]()
        parameters.updateValue("1", forKey: "version")
        
        Alamofire.request(rainURL, method: .get, parameters: parameters, headers: headers)
            .validate().responseData{ response in
                switch response.result{
                case .success:
                    if let data = response.data {
                        print("success")
                        var json = JSON(data)
                        //print(json)
                        x = json["weather"]["wIndex"]["uvindex"][0]["day00"]["comment"].stringValue
                        y = json["weather"]["wIndex"]["uvindex"][0]["day00"]["index"].stringValue
                        z = json["weather"]["wIndex"]["timeRelease"].stringValue
                        let start = z.index(z.startIndex, offsetBy: 11)
                        let end = z.index(z.endIndex, offsetBy: -6)
                        let range = start..<end
                        // print(z[range])//검색시간
                        //print("검색시간=\(z)")
                        //a = Int(z[range])!
                        print("x = \(x), y = \(y) , time = \(z[range])")
                        print("type = \(type(of:z[range]))")
                        if x.isEmpty {
                            x = json["weather"]["wIndex"]["uvindex"][0]["day02"]["comment"].stringValue
                            y = json["weather"]["wIndex"]["uvindex"][0]["day02"]["index"].stringValue
                            z = json["weather"]["wIndex"]["timeRelease"].stringValue
                            let start = z.index(z.startIndex, offsetBy: 11)
                            let end = z.index(z.endIndex, offsetBy: -6)
                            let range = start..<end
                            print("x = \(x), y = \(y) , time = \(z[range])")
                            if y.isEmpty {
                                uvArr = ["1"]
                            }
                            uvArr = [x,y,z[range]]
                            success(uvArr)
                        }else {
                            uvArr = [x,y,z[range]]
                            success(uvArr)
                        }
                    }
                case .failure:
                    print("error : \(response.error!)")
                }
        }
    }
    
    
}

