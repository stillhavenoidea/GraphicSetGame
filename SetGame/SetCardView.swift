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
    @IBInspectable
    var title = "Sample text"
    
    override func draw(_ rect: CGRect) {
        configureView()
        let maxY = bounds.maxY
        let maxX = bounds.maxX
        let diamondRect = CGRect(x: maxX/4, y: maxY/6, width: maxX/2, height: 2*maxY/3)
        UIRectFill(rect)
        let diamodView = DiamondSymbolView(frame: diamondRect)
        diamodView.backgroundColor = UIColor.clear
        addSubview(diamodView)
    }
    
    func configureView() {
        isOpaque = true
        UIColor.white.setFill()
        clipsToBounds = true
        contentMode = .redraw
        layer.cornerRadius = 5
        layer.borderColor = UIColor.yellow
            .cgColor
        layer.borderWidth = 1
    }
}
