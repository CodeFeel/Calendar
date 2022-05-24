//
//  ViewController.swift
//  CalendarDemo
//
//  Created by ios on 2021/11/16.
//

import UIKit
import SwifterBaseKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.color(hexString: "#F2F5F3")
        
        TMoreLog(message: Date().day)
        TMoreLog(message: Date().totalDaysInWeek)
        TMoreLog(message: Date().lastWeek.day)
        TMoreLog(message: Date().weekday)

        
        let calendarHeight: CGFloat = 30
        let rect = CGRect(x: 15, y: 100, width: kScreenWidth - 30, height: (kScreenWidth - 30)*6/7 + calendarHeight)
        let calendarView = CalendarView.init(with: rect, calendarHeadHeight: calendarHeight)
        view.addSubview(calendarView)
        
//        var date = Date()
//        TMoreLog(message: date)
//        
//        for i in 0..<(Date().weekday-1) {
//
//            date = date.lastDay
//            print(date)
//        }
//        
//        for i in date.weekday..<7 {
//            
//            date = date.nextDay
//            print(date)
//        }
        
    }


    
}

