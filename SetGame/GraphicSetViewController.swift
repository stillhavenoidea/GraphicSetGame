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
    @IBOutlet weak var gameZone: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawDeck()
    }
    
    
    @IBAction func onNewGamePressed(_ sender: UIButton) {
        print("New game pressed")
        clearTable()
        SetGame.singleton.startNewGame()
        drawDeck()
    }
    
    @IBAction func onDeal3MoreCardsPressed(_ sender: UIButton) {
        print("Deal 3 more cards pressed")
        SetGame.singleton.deal3MoreCards()
        clearTable()
        drawDeck()
    }
    
    func clearTable() {
        if cards.count > 0 {
        _ = cards.map{$0.removeFromSuperview()}
        cards = []
        }
    }
    
    func drawDeck() {
        var grid = Grid(layout: .aspectRatio(2/3), frame: gameZone.frame)
        let numberOfCards = SetGame.singleton.inGameCards.count
        grid.cellCount = numberOfCards
        for i in 0..<numberOfCards {
            let cardRect = grid[i]!.insetBy(dx: 2, dy: 2)
            var number: SetCardView.Number
            var shape: SetCardView.Shape
            var color: SetCardView.Color
            var shading: SetCardView.Shading
            
            switch SetGame.singleton.inGameCards[i].number {
            case .firstNumber:
                number = .single
            case .secondNumber:
                number = .double
            case .thirdNumber:
                number = .triple
            }
            
            switch SetGame.singleton.inGameCards[i].shape {
            case .firstShape:
                shape = .diamond
            case .secondShape:
                shape = .halfDiamond
            case .thirdShape:
                shape = .plateJewel
            }
            
            switch SetGame.singleton.inGameCards[i].color {
            case .firstColor:
                color = .yellow
            case .secondColor:
                color = .green
            case .thirdColor:
                color = .blue
            }
            
            switch SetGame.singleton.inGameCards[i].shading {
            case .firstShading:
                shading = .full
            case .secondShading:
                shading = .half
            case .thirdShading:
                shading = .empty
            }
            
            let card = SetCardView(frame: cardRect, number: number , shape: shape , color: color, shading: shading)
            view.addSubview(card)
            cards.append(card)
        }
    }
    
    
}
