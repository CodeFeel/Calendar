//
//  CalendarSymbolsView.swift
//  CalendarDemo
//
//  Created by ios on 2021/11/18.
//

import UIKit
import SwifterBaseKit

class CalendarSymbolsView: UIView {
    
    private(set) var daysInWeek = 7
    private var labels = [UILabel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeViews()
    }
    
    private func initializeViews() {
        for _ in 1...daysInWeek {
            let label = UILabel()
            label.textAlignment = .center
            labels.append(label)
            addSubview(label)
        }
        configure()
    }
    
    private func configure() {
        let weeks = Date().shortStandaWeekdaySymbols
        for (index, label) in labels.enumerated() {
            label.text = weeks[index]
            label.textColor = CalendarColor.daysSymbolsColor
            label.font = UIFont.pingFang(size: 10, traits: UIFont.SymbolicTraits.regular, isFit: false)
        }
    }
    
    override func layoutSubviews() {
        let width = bounds.width/daysInWeek.cgFloat
        for (i, label) in labels.enumerated() {
            label.frame = CGRect(x: i.cgFloat * width, y: 0, width: width, height: bounds.height)
        }
    }
}
