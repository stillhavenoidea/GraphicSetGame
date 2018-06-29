//
//  PlateJewelSymbolView.swift
//  SetGame
//
//  Created by MyMac on 17.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

class PlateJewelSymbolView: CardSymbolViewTemplate {

    override func getDrawingPoints() {
        drawingPoints.append(CGPoint(x: midX, y: topY))
        drawingPoints.append(CGPoint(x: leftX + 6*width/8, y: topY + height/4))
        drawingPoints.append(CGPoint(x: leftX + 6*width/8, y: topY + 3*height/4))
        drawingPoints.append(CGPoint(x: midX, y: bottomY))
        drawingPoints.append(CGPoint(x: leftX + 2*width/8, y: topY + 3*height/4))
        drawingPoints.append(CGPoint(x: leftX + 2*width/8, y: topY + height/4))
    }
}
