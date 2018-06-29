//
//  SetCardView.swift
//  SetGame
//
//  Created by MyMac on 10.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

@IBDesignable
class SetCardView: UIView {
    lazy var maxY = bounds.maxY
    lazy var maxX = bounds.maxX
    var symbolAlpha: CGFloat = 0
    var symbolColor: UIColor = UIColor.black
    var symbolNumber: Number = .single
    var symbolShape: Shape = .diamond
    var colorsArray: [UIColor] = [#colorLiteral(red: 0.1980642378, green: 0.52528584, blue: 0.08727363497, alpha: 1),#colorLiteral(red: 1, green: 0.7402812839, blue: 0, alpha: 1),#colorLiteral(red: 0.939566493, green: 0.1721510291, blue: 0.125985831, alpha: 1)]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, number: Number, shape: Shape, color: Color, shading: Shading) {
        switch color {
        case .green:
            symbolColor = colorsArray[0]
        case .yellow:
            symbolColor = colorsArray[1]
        case .blue:
            symbolColor = colorsArray[2]
        }
        
        switch shading {
        case .empty:
            symbolAlpha = 0
        case .half:
            symbolAlpha = 0.20
        case .full:
            symbolAlpha = 1
        }
        
        symbolNumber = number
        symbolShape = shape
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        configureView()
        UIRectFill(rect)
        placeOneOrMoreSymbols()
    }
    
    func configureView() {
        isOpaque = true
        UIColor.white.setFill()
        clipsToBounds = true
        contentMode = .redraw
        layer.cornerRadius = 5
    }
    
    func placeOneOrMoreSymbols() {
        switch symbolNumber {
        case .single:
            placeSingleSymbol()
        case .double:
            placeTwoSymbols()
        case .triple:
            placeThreeSymbols()
        }
    }
    
    func placeSingleSymbol() {
        let singleSymbolRect = CGRect(x: maxX/12,
                                 y: 4*maxY/18,
                                 width: 10*maxX/12,
                                 height: 10*maxY/18)
        let singleSymbolView = getSymbolForCurrentShape(symbolRect: singleSymbolRect)
        singleSymbolView.backgroundColor = UIColor.clear
        addSubview(singleSymbolView)
    }
    
    func placeTwoSymbols() {
        let firstSymbolRect = CGRect(x: 2*maxX/12,
                                y: maxY/18,
                                width: 8*maxX/12,
                                height: 8*maxY/18)
        let secondSymbolRect = CGRect(x: 2*maxX/12,
                                y: 9*maxY/18,
                                width: 8*maxX/12,
                                height: 8*maxY/18)
        let firstSymbolView = getSymbolForCurrentShape(symbolRect: firstSymbolRect)
        let secondSymbolView = getSymbolForCurrentShape(symbolRect: secondSymbolRect)
        firstSymbolView.backgroundColor = UIColor.clear
        secondSymbolView.backgroundColor = UIColor.clear
        addSubview(firstSymbolView)
        addSubview(secondSymbolView)
    }
    
    func placeThreeSymbols() {
        let firstSymbolRect = CGRect(x: 4*maxX/12,
                                     y: maxY/18,
                                     width: 4*maxX/12,
                                     height: 4*maxY/18)
        let secondSymbolRect = CGRect(x: 3*maxX/12,
                                      y: 6*maxY/18,
                                      width: 6*maxX/12,
                                      height: 6*maxY/18)
        let thirdSymbolRect = CGRect(x: 4*maxX/12,
                                      y: 13*maxY/18,
                                      width: 4*maxX/12,
                                      height: 4*maxY/18)
        let firstSymbolView = getSymbolForCurrentShape(symbolRect: firstSymbolRect)
        let secondSymbolView = getSymbolForCurrentShape(symbolRect: secondSymbolRect)
        let thirdSymbolView = getSymbolForCurrentShape(symbolRect: thirdSymbolRect)
        firstSymbolView.backgroundColor = UIColor.clear
        secondSymbolView.backgroundColor = UIColor.clear
        thirdSymbolView.backgroundColor = UIColor.clear
        addSubview(firstSymbolView)
        addSubview(secondSymbolView)
        addSubview(thirdSymbolView)
    }
    
    func getSymbolForCurrentShape(symbolRect: CGRect) -> CardSymbolViewTemplate {
        switch symbolShape {
        case .diamond:
            return DiamondSymbolView.init(frame: symbolRect, color: symbolColor, alpha: symbolAlpha)
        case .halfDiamond:
            return HalfDiamondSymbolView.init(frame: symbolRect, color: symbolColor, alpha: symbolAlpha)
        case .plateJewel:
            return PlateJewelSymbolView.init(frame: symbolRect, color: symbolColor, alpha: symbolAlpha)
        }
    }
    
    enum Number {
        case single
        case double
        case triple
    }
    
    enum Shape {
        case diamond
        case halfDiamond
        case plateJewel
    }
    
    enum Color {
        case yellow
        case green
        case blue
    }
    
    enum Shading {
        case empty
        case half
        case full
    }
}
