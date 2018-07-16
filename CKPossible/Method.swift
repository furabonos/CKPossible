//
//  Method.swift
//  CKPossible
//
//  Created by 엄태형 on 2017. 7. 22..
//  Copyright © 2017년 엄태형. All rights reserved.
//

import UIKit

class Method: NSObject {
    
    static func makeIcon(code: String, time: Int) -> UIImage {
        
        switch code {
        case "SKY_O00": return UIImage(named: "38.png")!
        case "SKY_O07": return UIImage(named: "18.png")!
        case "SKY_O08": return UIImage(named: "21.png")!
        case "SKY_O09": return UIImage(named: "32.png")!
        case "SKY_O10": return UIImage(named: "04.png")!
        case "SKY_O11": return UIImage(named: "29.png")!
        case "SKY_O12": return UIImage(named: "26.png")!
        case "SKY_O13": return UIImage(named: "27.png")!
        case "SKY_O14": return UIImage(named: "28.png")!
        case "SKY_O01":
            if 0 < time && time <= 5 {          // 0시부터 5시까지
                return UIImage(named: "08.png")!
            } else if 6 <= time && time <= 20 {
                return UIImage(named: "01.png")!
            } else {
                return UIImage(named: "08.png")!
            }
        case "SKY_O02":
            if 0 < time && time <= 5 {          // 0시부터 5시까지
                return UIImage(named: "09.png")!
            } else if 6 <= time && time <= 20 {
                return UIImage(named: "02.png")!
            } else {
                return UIImage(named: "09.png")!
            }
        case "SKY_O03":
            if 0 < time && time <= 5 {          // 0시부터 5시까지
                return UIImage(named: "10.png")!
            } else if 6 <= time && time <= 20 {
                return UIImage(named: "03.png")!
            } else {
                return UIImage(named: "10.png")!
            }
        case "SKY_O04":
            if 0 < time && time <= 5 {          // 0시부터 5시까지
                return UIImage(named: "40.png")!
            } else if 6 <= time && time <= 20 {
                return UIImage(named: "12.png")!
            } else {
                return UIImage(named: "40.png")!
            }
        case "SKY_O05":
            if 0 < time && time <= 5 {          // 0시부터 5시까지
                return UIImage(named: "41.png")!
            } else if 6 <= time && time <= 20 {
                return UIImage(named: "13.png")!
            } else {
                return UIImage(named: "41.png")!
            }
        case "SKY_O06":
            if 0 < time && time <= 5 {          // 0시부터 5시까지
                return UIImage(named: "42.png")!
            } else if 6 <= time && time <= 20 {
                return UIImage(named: "14.png")!
            } else {
                return UIImage(named: "42.png")!
            }
        default:
            return UIImage(named: "38.png")!
        }
    }
    static func selectCloth(owndo: Int) -> [UIImage] {
        var arr1 = Array<UIImage>()//이미지만 배열로 보낼것
        var arr2 = Array<String>()
        /*
         hoodie - 후드
         jacket1 - 콭
         jacket2 - 자켓
         jacket3 - 집엎
         jacket4 - 패딩
         jacket5 - 야구잠바
         jacket6 - 점퍼
         pullover - 맨투맨
         shirt - 반팔
         shirt1 - 긴팔셔츠
         shirt3 - 반팔셔츠
         */
        if owndo >= 25{
            arr1 = [UIImage(named: "shorts.png")!,UIImage(named: "shirt.png")!,UIImage(named: "jersey.png")!,UIImage(named: "polo.png")!]
            arr2 = ["반바지","반팔","져지","카라티"]
        }else if owndo >= 20 && owndo <= 24 {
            arr1 = [UIImage(named: "shorts.png")!,UIImage(named: "shirt.png")!,UIImage(named: "shirt1.png")!,UIImage(named: "polo.png")!,UIImage(named: "shirt3.png")!]
        }else if owndo >= 15 && owndo <= 19 {
            arr1 = [UIImage(named: "pullover.png")!,UIImage(named: "vest.png")!,UIImage(named: "shirt1.png")!,UIImage(named: "trenchcoat.png")!,UIImage(named: "jacket5.png")!]
        }else if owndo >= 10 && owndo <= 14 {
            arr1 = [UIImage(named: "pullover.png")!,UIImage(named: "vest.png")!,UIImage(named: "shirt1.png")!,UIImage(named: "hoodie.png")!,UIImage(named: "jacket5.png")!,UIImage(named: "jacket2.png")!,UIImage(named: "jacket3.png")!,UIImage(named: "jacket6.png")!]
        }else if owndo >= 5 && owndo <= 9 {
            arr1 = [UIImage(named: "pullover.png")!,UIImage(named: "vest.png")!,UIImage(named: "shirt1.png")!,UIImage(named: "hoodie.png")!,UIImage(named: "jacket5.png")!,UIImage(named: "jacket2.png")!,UIImage(named: "jacket3.png")!,UIImage(named: "trenchcoat.png")!]
        }else if owndo <= 4 && owndo > 0 {
            arr1 = [UIImage(named: "pullover.png")!,UIImage(named: "hoodie.png")!,UIImage(named: "jacket1.png")!,UIImage(named: "jacket3.png")!,UIImage(named: "jacket5.png")!]
        }else {
            arr1 = [UIImage(named: "pullover.png")!,UIImage(named: "hoodie.png")!,UIImage(named: "jacket1.png")!,UIImage(named: "jacket3.png")!,UIImage(named: "jacket5.png")!,UIImage(named: "jacket4.png")!]
        }
        return arr1
    }
    static func selectClothName(owndo: Int) -> [String] {
        var arr2 = Array<String>()
        /*
         hoodie - 후드
         jacket1 - 콭
         jacket2 - 자켓
         jacket3 - 집엎
         jacket4 - 패딩
         jacket5 - 야구잠바
         jacket6 - 점퍼
         pullover - 맨투맨
         shirt - 반팔
         shirt1 - 긴팔셔츠
         shirt3 - 반팔셔츠
         */
        if owndo >= 25{
            arr2 = ["반바지","반팔","져지","카라티"]
        }else if owndo >= 20 && owndo <= 24 {
            arr2 = ["반바지","반팔","긴팔셔츠","카라티","반팔셔츠"]
        }else if owndo >= 15 && owndo <= 19 {
            arr2 = ["맨투맨","베스트","긴팔셔츠","트렌치코트","야구점퍼"]
        }else if owndo >= 10 && owndo <= 14 {
            arr2 = ["맨투맨","베스트","긴팔셔츠","후드","야구점퍼","자켓","집엎","점퍼"]
        }else if owndo >= 5 && owndo <= 9 {
            arr2 = ["맨투맨","베스트","긴팔셔츠","후드","야구점퍼","자켓","집엎","트렌치코트"]
        }else if owndo <= 4 && owndo > 0 {
            arr2 = ["맨투맨","후드","코트","집엎","야구점퍼"]
        }else {
            arr2 = ["맨투맨","후드","코트","집엎","야구점퍼","패딩"]
        }
        return arr2
    }
    static func altMSG() -> UIAlertController {
        let alertmsg = UIAlertController(title: "경고", message: "검색어를 다시 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
        let alertaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertmsg.addAction(alertaction)
        return alertmsg
    }
    static func altMSG2() -> UIAlertController {
        let alertmsg = UIAlertController(title: "경고", message: "현재 해당지역은 검색이 되지 않습니다.\n 다른지역을 검색해주세요.", preferredStyle: UIAlertControllerStyle.alert)
        let alertaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertmsg.addAction(alertaction)
        return alertmsg
    }
    static func altMSG3() -> UIAlertController {
        let alertmsg = UIAlertController(title: "경고", message: "현재 해당위치는 검색이 되지 않습니다.\n 잠시후에 시도해주세요.", preferredStyle: UIAlertControllerStyle.alert)
        let alertaction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertmsg.addAction(alertaction)
        return alertmsg
    }
    static func selectDust(msg: String) -> UIImage {
        var dustPic = UIImage()
        if msg == "좋음" {
            dustPic = UIImage(named: "good.png")!
        }else if msg == "보통" {
            dustPic = UIImage(named: "normal.png")!
        }else if msg == "약간나쁨" {
            dustPic = UIImage(named: "fewsad.png")!
        }else if msg == "나쁨" {
            dustPic = UIImage(named: "sad.png")!
        }else if msg == "매우나쁨" {
            dustPic = UIImage(named: "verysad.png")!
        }
        return dustPic
    }
    static func selectDustMsg(msg: String) -> String {
        var dustMsg = String()
        if msg == "좋음" {
            dustMsg = "하늘이 깨끗합니다!"
        }else if msg == "보통" {
            dustMsg = "외출하기 적당합니다!"
        }else if msg == "약간나쁨" {
            dustMsg = "마스크를 챙기면 좋을것!"
        }else if msg == "나쁨" {
            dustMsg = "마스크를 꼭 쓰세요! 먼지가 많아요"
        }else if msg == "매우나쁨" {
            dustMsg = "외출하지 마세요!"
        }
        return dustMsg
    }
}
