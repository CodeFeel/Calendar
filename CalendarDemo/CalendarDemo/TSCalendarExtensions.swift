//
//  TSCalendarExtensions.swift
//  CalendarDemo
//
//  Created by ios on 2021/11/17.
//

import Foundation
import SwifterBaseKit

extension Date {
    
    var totalDaysInWeek: Int {
        guard let calendar = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.weekOfMonth, for: self) else {
            return 0
        }
        return calendar.count
    }
    
    var weekdayOrdinal: Int {
        return Calendar.current.component(.weekdayOrdinal, from: self)
    }
    
    /// 每月的总天数
    var totalDaysInMonth: Int {
        guard let calendar = Calendar.current.range(of: Calendar.Component.day, in: Calendar.Component.month, for: self) else {
            return 0
        }
        return calendar.count
    }
    
    /// 每月的第一天是星期几
    var firstWeekday: Int {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.day = 1
        let firstDay = Calendar.current.date(from: components)!
        return Calendar.current.ordinality(of: .weekday, in: .weekOfMonth, for: firstDay)! - 1
    }
    
    /// 上个月
    var lastMonth: Date {
        var components = DateComponents()
        components.month = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    /// 上个月
    var nextMonth: Date {
        var components = DateComponents()
        components.month = 1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    
    /// 上周
    var lastWeek: Date {
        var components = DateComponents()
        components.weekOfMonth = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    /// 下周
    var nextWeek: Date {
        var components = DateComponents()
        components.weekOfMonth = 1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    var lastDay: Date {
        var components = DateComponents()
        components.day = -1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    var nextDay: Date {
        var components = DateComponents()
        components.day = 1
        return Calendar.current.date(byAdding: components, to: self)!
    }
    
    /// 对应的农历
    var lunarDesc: String {
        let dayArrays = ["初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十","十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十","廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
        let monthArrays = ["正月","二月","三月","四月","五月","六月","七月","八月","九月","十月","冬月","腊月"]
        let calendar = Calendar.init(identifier: .chinese)
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        if components.day! - 1 == 0 {
            return monthArrays[components.month! - 1]
        }
        return dayArrays[components.day! - 1]
    }
    
    /// 周日 ~ 周六
    var shortStandaWeekdaySymbols: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "zh_CN")
        return dateFormatter.shortStandaloneWeekdaySymbols
    }
    
    
    
    
    
    
    
}
