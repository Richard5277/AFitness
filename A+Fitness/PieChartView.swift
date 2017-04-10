//
//  PieChartView.swift
//  A+Fitness
//
//  Created by Feihong Zhao on 2017-04-07.
//  Copyright © 2017 Feihong Zhao. All rights reserved.
//

import UIKit

class PieChart : UIView {
    
    var piechatColor: UIColor = UIColor(r: 250, g: 250, b: 250, a: 0.6)
    var startPercent: CGFloat = 0
    var endPercent: CGFloat = 100
    var newFrame: CGRect = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, color: UIColor,startPercent: CGFloat,endPercent: CGFloat){
        self.init()
        self.piechatColor = color
        self.startPercent = startPercent
        self.endPercent = endPercent
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        drawSlice(rect: rect, startPercent: 0, endPercent: 100, color: piechatColor)
    }
    
    private func drawSlice(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = startPercent / 100 * CGFloat(M_PI) * 2 - CGFloat(M_PI)
        let endAngle = endPercent / 100 * CGFloat(M_PI) * 2 - CGFloat(M_PI)
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        color.setFill()
        path.fill()
    }

    
}


