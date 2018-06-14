//
//  DiamondSymbolView.swift
//  SetGame
//
//  Created by MyMac on 10.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

@IBDesignable
class DiamondSymbolView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        //    var maxY = bounds.height
        //    var maxX = bounds.width
        //    var midY = bounds.midY
        //    var midX = bounds.midX
        let maxY = bounds.maxY
        let maxX = bounds.maxX
        let midY = maxY/2
        let midX = maxX/2
        let path = UIBezierPath()
        let firstPoint = CGPoint(x: midX, y: 0)
        let secondPoint = CGPoint(x: maxX, y: midY)
        let thirdPoint = CGPoint(x: midX, y: maxY)
        let fourthPoint = CGPoint(x: 0, y: midY)
        UIColor.clear.setFill()
        UIRectFill(rect)
        path.lineWidth = 1
        path.move(to: firstPoint)
        path.addLine(to: secondPoint)
        path.addLine(to: thirdPoint)
        path.addLine(to: fourthPoint)
        path.close()
        UIColor.red.setStroke()
        UIColor.red.withAlphaComponent(0.5).setFill()
        path.stroke()
        path.fill()
        
    }
    
}
