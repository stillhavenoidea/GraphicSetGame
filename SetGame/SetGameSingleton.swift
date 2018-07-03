//
//  SetGame
//
//  Created by MyMac on 01.05.18.
//  Copyright © 2018 SoftDevelopingOrganizationName. All rights reserved.
//

import Foundation

class SetGameSingleton {
    private(set) static var instance: SetGameSingleton! = SetGameSingleton()
    private var deck: [SetCard] = []
    private let initialCardQuantity = 12
    var inGameCards: [SetCard] = []
    private(set) var gameScores: Int = 0 { didSet { if gameScores < 0 {gameScores = 0} }  }
    
    private init() {
        generateFullDeck()
        dealSomeCards(numberOfCards: initialCardQuantity)
    }
    
    deinit {
        print("MODEL: Deallocating game instance")
    }
    
    func startNewGame() {
        SetGameSingleton.instance = nil
        SetGameSingleton.instance = SetGameSingleton()
    }
    

    private func generateFullDeck() {
       //Generating 81 card deck using raw-value initalizers with nested cycles
        print("MODEL: Deck is generating")
        for numberInt in 0...2 {
            for shapeInt in 0...2 {
                for colorInt in 0...2 {
                    for shadengInt in 0...2 {
                        deck.append(SetCard(number: SetCard.Number.init(rawValue: numberInt)!,
                                            shape: SetCard.Shape.init(rawValue: shapeInt)!,
                                            color: SetCard.Color.init(rawValue: colorInt)!,
                                            shading: SetCard.Shading.init(rawValue: shadengInt)!, isSelected: false))
                    }
                }
            }
        }
    }
   
    private func dealSomeCards(numberOfCards: Int) {
        if deck.count >= numberOfCards {
            for _ in 0..<numberOfCards {
                let randomIndex = Int(arc4random_uniform(UInt32(deck.count)))
                inGameCards.append(deck.remove(at: randomIndex))
            }
        }
    }
    
    func deal3MoreCards() {
        dealSomeCards(numberOfCards: 3)
    }
    
    func processCards(indexArray: [Int]) -> Bool {
        if indexArray.count == 3 {
            let firstCard = inGameCards[indexArray[0]]
            let secondCard = inGameCards[indexArray[1]]
            let thirdCard = inGameCards[indexArray[2]]
            let acceptableSumValueSet = [0,3,6]
            let numberRawVauleSum = firstCard.number.rawValue + secondCard.number.rawValue + thirdCard.number.rawValue
            let shapeRawVauleSum = firstCard.shape.rawValue + secondCard.shape.rawValue + thirdCard.shape.rawValue
            let colorRawVauleSum = firstCard.color.rawValue + secondCard.color.rawValue + thirdCard.color.rawValue
            let shadingRawVauleSum = firstCard.shading.rawValue + secondCard.shading.rawValue + thirdCard.shading.rawValue
            if  acceptableSumValueSet.contains(numberRawVauleSum) &&
                acceptableSumValueSet.contains(shapeRawVauleSum) &&
                acceptableSumValueSet.contains(colorRawVauleSum) &&
                acceptableSumValueSet.contains(shadingRawVauleSum) {
                print("Is set")
                removeCards(firstCard, secondCard, thirdCard)
                recalculateScores(wasSet: true)
                return true
            } else {
                print("Not a set")
                inGameCards[indexArray[0]].isSelected = false
                inGameCards[indexArray[1]].isSelected = false
                inGameCards[indexArray[2]].isSelected = false
                recalculateScores(wasSet: false)
                return false
            }
        } else { return false }
    }
    
    private func recalculateScores(wasSet: Bool) {
        if wasSet {
            gameScores += 10
        } else {
            gameScores -= 5
        }
    }
    
    private func removeCards(_ cards: SetCard...) {
        for card in cards {
            let cardIndex = inGameCards.index(of: card)!
            inGameCards.remove(at: cardIndex)
        }
    }
    
    func getNumberOfCardsLeft() -> Int {
        return deck.count
    }
    
}

struct SetCard: Equatable {
    let number: Number
    let shape: Shape
    let color: Color
    let shading: Shading
    var isSelected = false
    
    static func ==(lhs: SetCard, rhs: SetCard) -> Bool {
        return (lhs.number == rhs.number)
            && (lhs.color == rhs.color)
            && (lhs.shape == rhs.shape)
            && (lhs.shading == rhs.shading)
    }
    
    enum Number: Int {
        case firstNumber
        case secondNumber
        case thirdNumber
    }
    
    enum Shape: Int {
        case firstShape
        case secondShape
        case thirdShape
    }
    
    enum Color: Int {
        case firstColor
        case secondColor
        case thirdColor
    }
    
    enum Shading: Int {
        case firstShading
        case secondShading
        case thirdShading
    }
}


