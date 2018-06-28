//
//  HalfDiamondSymbolView.swift
//  SetGame
//
//  Created by MyMac on 14.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

class HalfDiamondSymbolView: CardSymbolViewTemplate {

    override func getDrawingPoints() {
        drawingPoints.append(CGPoint(x: leftX + width/4, y: topY))
        drawingPoints.append(CGPoint(x: leftX + 3*width/4, y: topY))
        drawingPoints.append(CGPoint(x: leftX + width, y: topY + height/4))
        drawingPoints.append(CGPoint(x: midX, y: topY + height))
        drawingPoints.append(CGPoint(x: leftX, y: topY + height/4))
    }
}
