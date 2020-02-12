//
//  TicTacToeModel.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 08/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

// MARK: - TicTacToeModel
/// Manage the states of the board and handle the inputs from the Board View
class TicTacToeModel{
    
    var board = [SquareModel]()
    var activePlayer = Player.x
    
    private let rowSize:Int
    
    
    /// Init for TicTacToeModel
    /// - Parameter rowSize: The size of row (E.g rowSize = 3 will build an array of 9)
    init(rowSize: Int) {
        self.rowSize = rowSize
        for _ in (0 ..< self.rowSize * self.rowSize){
            board.append(SquareModel(status: .empty))
        }
    }
    
    
    /// Reflects the input of the user in board
    /// - Parameters:
    ///   - index: The index of the square
    ///   - player: The status to set in the Square
    func makeMove(index: Int, player:Player) {
        
        if board[index].status == .empty {
            #if DEBUG
            print("✅ The Square is empty")
            #endif
            let selectionFeedback = UISelectionFeedbackGenerator()
            selectionFeedback.selectionChanged()
            board[index].status = player
            #if DEBUG
            print("◻️ Square: \(index) set to: \(board[index].status)")
            #endif
            self.changePlayer()
        }else{
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            #if DEBUG
            print("🚫 Square \(index) alredy filled with: \(board[index].status) ")
            #endif
        }
    }
    
    
    /// Resets all the squares of the board to Player.empty
    func resetGame() {
        for n in (0 ..< self.rowSize * self.rowSize){
            board[n].status = .empty
        }
    }
    
    
    /// Toggles between players .x and .o
    func changePlayer (){
        switch self.activePlayer {
        case .x:
            self.activePlayer = .o
        case .o:
            self.activePlayer = .x
        case .empty:
            break
        }
    }
    
    
    
    /// Check if one of the players has won or if its a draw.
    func isGameOver() -> (isGameOver: Bool, winner:Player) {
        let isAwinner = checkForWinner().isAWinner
        if isAwinner {
            let winner = checkForWinner().player
            return (isAwinner, winner)
        }else{
            let gameState = board.compactMap({$0.status})
            let hasAllItemsEqual = gameState.dropFirst().allSatisfy({ $0 != Player.empty })
            if hasAllItemsEqual {
                #if DEBUG
                print("🙅🏾 Draw!!!")
                #endif
                return (true,Player.empty)
            }
        }
        return (false,Player.empty)
    }
    
    
    /// Check if one of the players wins and return true, otherwise return false and .empty
    func checkForWinner() -> (isAWinner:Bool, player:Player){
        let gameState = board.compactMap({$0.status})
        var player = Player.empty
        #if DEBUG
        print("📏 \(gameState.compactMap({$0.string}))")
        #endif
        for combinations in Definitions().winPatterns{
            if gameState[combinations[0]] != Player.empty && gameState[combinations[0]] == gameState[combinations[1]] &&  gameState[combinations[1]] == gameState[combinations[2]]{
                if gameState[combinations[0]] == Player.x{
                    player = Player.x
                    #if DEBUG
                    print("❌ has won! 🎉 ")
                    #endif
                }else{
                    player = Player.o
                    #if DEBUG
                    print("⭕️ has won! 🎉 ")
                    #endif
                }
                return (true, player)
            }
        }
        return (false, player)
    }
}

// MARK: - Player Enum

/// Player Enum
enum Player:UInt8 {
    
    case empty //0
    case x
    case o
    
    
    var imageName: String {
        switch self {
        case .o:
            return "nought"
        case .x:
            return "cross"
        case .empty:
            return "empty"
        }
    }
    
    var string : String{
        switch self {
        case .o:
            return "⭕️"
        case .x:
            return "❌"
        case .empty:
            return ""
        }
    }
    
}
