//
//  CalendarDateModel.swift
//  CalendarDemo
//
//  Created by ios on 2021/11/18.
//

import Foundation
import SwifterBaseKit

public struct CalendarDateModel {
    /// 阳历（新历）
    var solarDate = ""
    /// 阴历（农历）
    var lunarDate = ""
    
    var isCurrentMonth = false
    
    var isCurrentDay = false
    
    var isSportsDate = false
}

public class CalendarDataSouce {
    /// 选择的日期
    var date = Date()
    /// 选择的日期对应年份
    var year = 0
    /// 选择的日期对应月份
    var month = 0
    /// 每月的总天数
    var totalDays = 0
    /// 每月的第一天是星期几
    var firstWeekday = 0
    /// 日期模型数组
    var dayModels = [CalendarDateModel]()
    
    init(_ date: Date) {
        self.date = date
        self.totalDays = date.totalDaysInMonth
        self.firstWeekday = date.firstWeekday
        self.year = date.year
        self.month = date.month
//        self.loadMonthData()
        self.loadWeekDatas()
    }
    
    private func loadMonthData() {
        
        self.dayModels = [CalendarDateModel]()
        
        let previousMonthDays = date.lastMonth.totalDaysInMonth
        let previousBeginDay = previousMonthDays - firstWeekday + 1
        let previousEndDay = previousMonthDays
        if previousBeginDay <= previousEndDay {
            for index in previousBeginDay...previousEndDay {
                let previousDate = Date.date(year: date.lastMonth.year, month: date.lastMonth.month, day: index)
                var dayModel = CalendarDateModel()
                dayModel.solarDate = String(format: "%d", index)
                dayModel.lunarDate = previousDate.lunarDesc
                dayModels.append(dayModel)
            }
        }
        
        for index in 1...totalDays {
            let currentDate = Date.date(year: year, month: month, day: index)
            var dayModel = CalendarDateModel()
            dayModel.solarDate = String(format: "%d", index)
            dayModel.lunarDate = currentDate.lunarDesc
            dayModel.isCurrentMonth = true
            if Date().day == index {
                dayModel.isCurrentDay = true
            }
            dayModels.append(dayModel)
        }
        
        var nextMonthDays = firstWeekday + totalDays
        /// 42指的是日历按照6行7列排满
        nextMonthDays = 42 - nextMonthDays
        if nextMonthDays >= 1 {
            for index in 1...nextMonthDays {
                let nextDate = Date.date(year: date.nextMonth.year, month: date.nextMonth.month, day: index)
                var dayModel = CalendarDateModel()
                dayModel.solarDate = String(format: "%d", index)
                dayModel.lunarDate = nextDate.lunarDesc
                dayModels.append(dayModel)
            }
        }
    }
    
    private func loadWeekDatas() {
        
        self.dayModels = [CalendarDateModel]()
        
        var lastDate = date
        for _ in 0..<(date.weekday-1) {
            lastDate = lastDate.lastDay
            print(date)
            var dayModel = CalendarDateModel()
            dayModel.solarDate = String(format: "%d", lastDate.day)
            dayModel.lunarDate = lastDate.lunarDesc
            dayModels.append(dayModel)
        }
        dayModels = dayModels.reversed()
        
        var dayModel = CalendarDateModel()
        dayModel.solarDate = String(format: "%d", date.day)
        dayModel.lunarDate = date.lunarDesc
        dayModels.append(dayModel)
        
        var nextDate = date
        for _ in date.weekday..<7 {
            nextDate = nextDate.nextDay
            print(date)
            var dayModel = CalendarDateModel()
            dayModel.solarDate = String(format: "%d", nextDate.day)
            dayModel.lunarDate = nextDate.lunarDesc
            dayModels.append(dayModel)
        }
    }
}
