//
//  CardSymbolView.swift
//  SetGame
//
//  Created by MyMac on 17.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

class CardSymbolViewTemplate: UIView {
    lazy var delta = bounds.maxY * 0.1
    lazy var width = bounds.maxX - 2 * delta
    lazy var height = bounds.maxY - 2 * delta
    lazy var bottomY = bounds.maxY - delta
    lazy var rightX = bounds.maxX - delta
    lazy var midY = bounds.maxY / 2
    lazy var midX = bounds.maxX / 2
    lazy var leftX = delta
    lazy var topY = delta
    lazy var lineWidths = bounds.maxY * 0.05
    var drawingPoints: [CGPoint] = []
    let path = UIBezierPath()
    let symbolColor: UIColor
    let symbolAlpha: CGFloat
    
    init(frame: CGRect, color: UIColor, alpha: CGFloat) {
        symbolAlpha = alpha
        symbolColor = color
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        configureView()
        getDrawingPoints()
        addSymbolLines()
        configureAndDisplaySymbol()
    }
    
    func configureView() {
        isOpaque = true
        UIColor.clear.setFill()
        clipsToBounds = true
        contentMode = .redraw
    }
    
    func getDrawingPoints() {
        //Abstract method. Needs to be implemented in subclass
    }
    
    func addSymbolLines() {
        path.move(to: drawingPoints[0])
        for point in drawingPoints[1...] {
            path.addLine(to: point)
        }
        path.close()
    }
    
    func configureAndDisplaySymbol() {
        symbolColor.setStroke()
        symbolColor.withAlphaComponent(symbolAlpha).setFill()
        path.lineWidth = lineWidths
        path.stroke()
        path.fill()
    }
}
