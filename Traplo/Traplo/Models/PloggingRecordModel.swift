//
//  PloggingRecord.swift
//  Traplo
//
//  Created by 김상현 on 2021/08/25.
//

import Foundation

struct PloggingRecordModel {
    let date:date
    let distance:Float
    let time:Float
    let start:String
    let end:String
    init(date:date,distance:Float,time:Float,start:String,end:String) {
        self.date = date
        self.distance = distance
        self.time = time
        self.start = start
        self.end = end
    }
}
struct date {
    let year:Int
    let month:Int
    let day:Int
    init(year:Int,month:Int,day:Int) {
        self.year = year
        self.month = month
        self.day = day
    }
    var date: String{
        return "\(year)+.+\(month)+.+\(day)"
    }
}
