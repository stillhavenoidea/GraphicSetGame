//
//  GraphicSetViewController.swift
//  SetGame
//
//  Created by MyMac on 10.06.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import UIKit

class GraphicSetViewController: UIViewController {
    var cards: [SetCardView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cardRect = CGRect(x: 50, y: 50, width: 60, height: 100)
        let card = SetCardView(frame: cardRect)
//        card.backgroundColor = UIColor.yellow
        view.addSubview(card)
        cards.append(card)
    }
    
    @IBAction func onNewGamepressed(_ sender: UIButton) {
    print("New game pressed")
    }
    
    @IBAction func onDeal3MoreCardsPressed(_ sender: UIButton) {
        cards[0].layer.borderColor = UIColor.blue.cgColor
        cards[0].layer.borderWidth = 5
        print("Deal 3 more cards pressed")
    }
}
