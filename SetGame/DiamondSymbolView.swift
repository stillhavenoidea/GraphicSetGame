//
//  DiamondSymbolView.swift
//  SetGame
//
//  Created by MyMac on 10.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

@IBDesignable
class DiamondSymbolView: CardSymbolViewTemplate {
    
    override func getDrawingPoints() {
        drawingPoints.append(CGPoint(x: midX, y: topY))
        drawingPoints.append(CGPoint(x: leftX + 7*width/8, y: midY))
        drawingPoints.append(CGPoint(x: midX, y: bottomY))
        drawingPoints.append(CGPoint(x: leftX + width/8, y: midY))
    }
}
