//
//  TSCalendarView.swift
//  CalendarDemo
//
//  Created by ios on 2021/11/17.
//

import UIKit
import SwifterBaseKit

class CalendarView: UIView {

    var symbolsView: CalendarSymbolsView!
    var collectionView: UICollectionView!
    var headHeight: CGFloat = 0
    var dateArray = [CalendarDateModel]()
    var currentDate = Date()
    
    public init(with frame: CGRect, calendarHeadHeight: CGFloat) {
        super.init(frame: frame)
        self.cornerRadius = 5
        self.clipsToBounds = true
        self.headHeight = calendarHeadHeight
        initializeViews()
        addSwipeGesture()
        reloadDate()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initializeViews() {
        symbolsView = CalendarSymbolsView.init(frame: CGRect(x: 0, y: 0, width: bounds.width, height: headHeight))
        addSubview(symbolsView)
        
        let flow = UICollectionViewFlowLayout()
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 0
        flow.itemSize = CGSize(width: bounds.width/7.0, height: (bounds.height - headHeight)/6.0)
        flow.sectionInset = .zero
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collectionView.frame = CGRect(x: 0, y: symbolsView.frame.maxY, width: bounds.width, height: bounds.height - headHeight)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.register(cellType: CalendarDateCell.self)
        addSubview(collectionView)
    }
    
    private func addSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.goToPrevious))
        swipeLeft.direction = .right
        collectionView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.goToNext))
        swipeRight.direction = .left
        collectionView.addGestureRecognizer(swipeRight)
    }
}

extension CalendarView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateArray.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CalendarDateCell.self)
        
        cell.model = dateArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}

extension CalendarView {
        
    private func reloadDate() {
        dateArray = CalendarDataSouce(currentDate).dayModels
        collectionView.reloadData()
    }
    
    private func addAnimations(_ subtype: CATransitionSubtype) {
        let catranstion = CATransition()
        catranstion.duration = 0.3
        catranstion.type = .push
        catranstion.subtype = subtype
        catranstion.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeInEaseOut)
        collectionView.layer.add(catranstion, forKey: nil)
    }
}

//MARK:手势
extension CalendarView {
    
    @objc func goToPrevious() {
        addAnimations(.fromLeft)
//        currentDate = currentDate.lastMonth
        currentDate = currentDate.lastWeek
        reloadDate()
    }
    
    @objc func goToNext() {
        addAnimations(.fromRight)
//        currentDate = currentDate.nextMonth
        currentDate = currentDate.nextWeek
        reloadDate()
    }
}
