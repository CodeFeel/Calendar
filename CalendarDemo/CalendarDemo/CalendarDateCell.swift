//
//  CalendarDateCell.swift
//  CalendarDemo
//
//  Created by ios on 2021/11/18.
//

import UIKit
import Reusable
import SwifterBaseKit
import SnapKit

class CalendarDateCell: UICollectionViewCell, Reusable {
    
    lazy var dateLb: UILabel = {
        let db = UILabel()
        db.backgroundColor = UIColor.white
        db.clipsToBounds = true
        db.font = UIFont.pingFang(size: 12, traits: .regular, isFit: false)
        db.textAlignment = .center
        contentView.addSubview(db)
        return db
    }()
    
    lazy var sportsView: UIView = {
        let sw = UIView()
        sw.backgroundColor = UIColor.clear
        sw.clipsToBounds = true
        sw.borderWidth = 2
        sw.borderColor = CalendarColor.sportsColor
        contentView.addSubview(sw)
        return sw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        dateLb.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
//        sportsView.cornerRadius = bounds.width/3
//        sportsView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.width.height.equalTo(bounds.width/1.5)
//        }
    }
    
    var model: CalendarDateModel? {
        didSet {
            guard let model = model else { return }
            dateLb.text = model.solarDate
            dateLb.textColor = model.isCurrentMonth ? CalendarColor.currentMonthColor : CalendarColor.otherMonthColor
        }
    }
}
