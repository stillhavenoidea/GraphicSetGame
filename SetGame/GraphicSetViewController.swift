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
    var selectedCardNumbers: [Int] = []
    @IBOutlet weak var gameZone: UIView!
    @IBOutlet weak var scoresLabel: UILabel!
    @IBOutlet weak var cardsLeftLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        drawDeck()
        showGameInfo()
    }
    
    
    @IBAction func onNewGamePressed(_ sender: UIButton) {
        print("New game pressed")
        clearTable()
        SetGameSingleton.instance.startNewGame()
        drawDeck()
    }
    
    @IBAction func onDeal3MoreCardsPressed(_ sender: UIButton) {
        print("Deal 3 more cards pressed")
        SetGameSingleton.instance.deal3MoreCards()
        clearTable()
        drawDeck()
    }
    
    func clearTable() {
        if cards.count > 0 {
        _ = cards.map{$0.removeFromSuperview()}
        cards = []
        selectedCardNumbers = []
        }
    }
    
    func drawDeck() {
        var grid = Grid(layout: .aspectRatio(2/3), frame: gameZone.frame)
        let numberOfCards = SetGameSingleton.instance.inGameCards.count
        grid.cellCount = numberOfCards
        for i in 0..<numberOfCards {
            let cardRect = grid[i]!.insetBy(dx: 2, dy: 2)
            var number: SetCardView.Number
            var shape: SetCardView.Shape
            var color: SetCardView.Color
            var shading: SetCardView.Shading
            
            switch SetGameSingleton.instance.inGameCards[i].number {
            case .firstNumber:
                number = .single
            case .secondNumber:
                number = .double
            case .thirdNumber:
                number = .triple
            }
            
            switch SetGameSingleton.instance.inGameCards[i].shape {
            case .firstShape:
                shape = .diamond
            case .secondShape:
                shape = .halfDiamond
            case .thirdShape:
                shape = .plateJewel
            }
            
            switch SetGameSingleton.instance.inGameCards[i].color {
            case .firstColor:
                color = .yellow
            case .secondColor:
                color = .green
            case .thirdColor:
                color = .blue
            }
            
            switch SetGameSingleton.instance.inGameCards[i].shading {
            case .firstShading:
                shading = .full
            case .secondShading:
                shading = .half
            case .thirdShading:
                shading = .empty
            }
            
            let card = SetCardView(frame: cardRect, number: number , shape: shape , color: color, shading: shading)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCardTapped(recognizer:)))
            card.addGestureRecognizer(tapGesture)
            view.addSubview(card)
            cards.append(card)
            if SetGameSingleton.instance.inGameCards[i].isSelected { selectView(card)}
        }
        showGameInfo()
    }
    
    @objc func onCardTapped(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .ended:
            let sender  = recognizer.view as! SetCardView
            processSelectedCard(sender)
        default:
            print("Aborted")
        }
    }
    
    func processSelectedCard(_ sender: SetCardView) {
        if selectedCardNumbers.count < 3 {
            
            let cardIndex = cards.index(of: sender)!
            print("CARD \(cardIndex) TAPPED")
            if SetGameSingleton.instance.inGameCards[cardIndex].isSelected {
                SetGameSingleton.instance.inGameCards[cardIndex].isSelected = false
                deSelectView(sender)
                selectedCardNumbers.remove(at: selectedCardNumbers.index(of: cardIndex)!)
            } else {
                SetGameSingleton.instance.inGameCards[cardIndex].isSelected = true
                selectedCardNumbers.append(cardIndex)
                selectView(sender)
                if selectedCardNumbers.count == 3 {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                        let result = SetGameSingleton.instance.processCards(indexArray: self.selectedCardNumbers)
                        if result {
                            UIViewPropertyAnimator.runningPropertyAnimator(
                                withDuration: 0.5,
                                delay: 0,
                                options: [],
                                animations: {
                                    for i in self.selectedCardNumbers {
                                        self.cards[i].alpha = 0
                                    }
                                    
                            },
                                completion: { position in
                                    self.clearTable()
                                    self.drawDeck()})
                        }
                        self.selectedCardNumbers = []
                        self.deSelectAllViews()
                    }
                }
                showGameInfo()
            }
        } else { print("Tap ignored!") }
    }
    
    func selectView(_ cardView: SetCardView) {
        cardView.layer.borderColor = UIColor.red.cgColor
        cardView.layer.borderWidth = 3
    }
    
    
    func deSelectView(_ cardView: SetCardView) {
        cardView.layer.borderWidth = 0
    }
    
    func deSelectAllViews() {
        _ = cards.map { $0.layer.borderWidth = 0 }
    }
    
    func showGameInfo() {
        scoresLabel.text = ("Scores: \(SetGameSingleton.instance.gameScores)")
        cardsLeftLabel.text = ("Cards left: \(SetGameSingleton.instance.getNumberOfCardsLeft())")
    }
}
