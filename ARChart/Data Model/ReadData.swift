//
//  ReadData.swift
//  ARChart
//
//  Created by Anan Ratanasethakul on 1/5/19.
//  Copyright © 2019 Anan Ratanasethakul. All rights reserved.
//

import UIKit

struct ReadPlotData {
    let yyyymmdd: String
    let date: String
    let ddmm: String
    let day: Int
    let books: Int
    let pages: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    func toSeconds() -> CGFloat {
        return CGFloat(hours*3600 + minutes*60 + seconds)
        
    }
}

class ReadData {
    static func samples() -> [ReadPlotData] {
        let data1 = ReadPlotData(yyyymmdd: "25620401", date: "1 เมษายน 2562", ddmm: "1/4", day: 1, books: 1, pages: 5, hours: 0, minutes: 12, seconds: 37)
        let data2 = ReadPlotData(yyyymmdd: "25620402", date: "2 เมษายน 2562", ddmm: "2/4", day: 2, books: 0, pages: 0, hours: 0, minutes: 0, seconds: 0)
        let data3 = ReadPlotData(yyyymmdd: "25620403", date: "3 เมษายน 2562", ddmm: "3/4", day: 3, books: 2, pages: 25, hours: 0, minutes: 34, seconds: 39)
        let data4 = ReadPlotData(yyyymmdd: "25620404", date: "4 เมษายน 2562", ddmm: "4/4", day: 4, books: 1, pages: 15, hours: 0, minutes: 18, seconds: 23)
        let data5 = ReadPlotData(yyyymmdd: "25620405", date: "5 เมษายน 2562", ddmm: "5/4", day: 5, books: 1, pages: 10, hours: 0, minutes: 15, seconds: 49)
        let data6 = ReadPlotData(yyyymmdd: "25620406", date: "6 เมษายน 2562", ddmm: "6/4", day: 6, books: 1, pages: 5, hours: 0, minutes: 10, seconds: 11)
        let data7 = ReadPlotData(yyyymmdd: "25620407", date: "7 เมษายน 2562", ddmm: "7/4", day: 0, books: 2, pages: 35, hours: 1, minutes: 12, seconds: 17)
        let data8 = ReadPlotData(yyyymmdd: "25620408", date: "8 เมษายน 2562", ddmm: "8/4", day: 1, books: 1, pages: 7, hours: 0, minutes: 12, seconds: 8)
        let data9 = ReadPlotData(yyyymmdd: "25620409", date: "9 เมษายน 2562", ddmm: "9/4", day: 2, books: 1, pages: 15, hours: 0, minutes: 22, seconds: 46)
        let data10 = ReadPlotData(yyyymmdd: "25620410", date: "10 เมษายน 2562", ddmm: "10/4", day: 3, books: 1, pages: 5, hours: 0, minutes: 15, seconds: 44)
        let data11 = ReadPlotData(yyyymmdd: "25620411", date: "11 เมษายน 2562", ddmm: "11/4", day: 4, books: 1, pages: 5, hours: 0, minutes: 12, seconds: 37)
        let data12 = ReadPlotData(yyyymmdd: "25620412", date: "12 เมษายน 2562", ddmm: "12/4", day: 5, books: 0, pages: 0, hours: 0, minutes: 0, seconds: 0)
        let data13 = ReadPlotData(yyyymmdd: "25620413", date: "13 เมษายน 2562", ddmm: "13/4", day: 6, books: 2, pages: 25, hours: 0, minutes: 34, seconds: 39)
        
        let data14 = ReadPlotData(yyyymmdd: "25620414", date: "14 เมษายน 2562", ddmm: "14/4", day: 0, books: 1, pages: 5, hours: 0, minutes: 12, seconds: 37)
        let data15 = ReadPlotData(yyyymmdd: "25620415", date: "15 เมษายน 2562", ddmm: "15/4", day: 1, books: 0, pages: 0, hours: 0, minutes: 0, seconds: 0)
        let data16 = ReadPlotData(yyyymmdd: "25620416", date: "16 เมษายน 2562", ddmm: "16/4", day: 2, books: 2, pages: 25, hours: 0, minutes: 34, seconds: 39)
        let data17 = ReadPlotData(yyyymmdd: "25620417", date: "17 เมษายน 2562", ddmm: "17/4", day: 3, books: 1, pages: 15, hours: 0, minutes: 18, seconds: 23)
        let data18 = ReadPlotData(yyyymmdd: "25620418", date: "18 เมษายน 2562", ddmm: "18/4", day: 4, books: 1, pages: 10, hours: 0, minutes: 15, seconds: 49)
        let data19 = ReadPlotData(yyyymmdd: "25620419", date: "19 เมษายน 2562", ddmm: "19/4", day: 5, books: 1, pages: 5, hours: 0, minutes: 10, seconds: 11)
        let data20 = ReadPlotData(yyyymmdd: "25620420", date: "20 เมษายน 2562", ddmm: "20/4", day: 6, books: 2, pages: 35, hours: 1, minutes: 12, seconds: 17)
        let data21 = ReadPlotData(yyyymmdd: "25620421", date: "21 เมษายน 2562", ddmm: "21/4", day: 0, books: 1, pages: 7, hours: 0, minutes: 12, seconds: 8)
        let data22 = ReadPlotData(yyyymmdd: "25620422", date: "22 เมษายน 2562", ddmm: "22/4", day: 1, books: 1, pages: 15, hours: 0, minutes: 22, seconds: 46)
        let data23 = ReadPlotData(yyyymmdd: "25620423", date: "23 เมษายน 2562", ddmm: "23/4", day: 2, books: 1, pages: 5, hours: 0, minutes: 15, seconds: 44)
        let items = [data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15, data16, data17, data18, data19, data20, data21, data22, data23]
        return items
    }
}
