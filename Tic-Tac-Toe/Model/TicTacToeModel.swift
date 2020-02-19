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
    var isNPCEnabled = false
    
    private let rowSize:Int
    
    
    /// return the indices of `Player.empty` squares
    ///
    /// E.g. [.empty,.o,.x,.o,.x,.o,.x,.o,.empty] --> [0,8]
    var emptySquares: [Int]  {
        return self.board.indices.filter {self.board[$0].status == .empty}
    }
    
    
    /// Init for TicTacToeModel
    /// - Parameter rowSize: The size of row
    ///
    /// (E.g rowSize = 3 will build an array of 9)
    init(rowSize: Int) {
        self.rowSize = rowSize
        self.createBoard()
    }
    
    
    /// Init for TicTacToeModel
    /// - Parameters:
    ///   - rowSize: The size of row
    ///   (E.g rowSize = 3 will build an array of 9)
    ///   - enableAI: Set the AI, true or false when the board is created
    init (rowSize: Int, enableAI:Bool){
        self.rowSize = rowSize
        self.createBoard()
        self.isNPCEnabled = enableAI
    }
    
    
    /// Create the initial board with `Player.empty` Squares
    private func createBoard (){
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
             let impactMed = UIImpactFeedbackGenerator(style: .medium)
                           impactMed.impactOccurred()
            board[index].status = player
            #if DEBUG
            print("◻️ Square: \(index) set to: \(board[index].status)")
            self.changePlayer()
            #endif
        }else{
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            #if DEBUG
            print("🚫 Square \(index) alredy filled with: \(board[index].status) ")
            #endif
        }
    }
    
    
    /// Select a random `.empty` Square
    /// - Parameter player: The player we select as NPC player
    func makeNPCMove(player: Player) {
        if self.isNPCEnabled {
            //Select a random empty Square
            #if DEBUG
            print("\(emptySquares)")
            #endif
            let selectedSquare = Int.random(in: 0..<emptySquares.count)
            self.makeMove(index: emptySquares[selectedSquare], player: player)
        }
    }
    
    
    /// Resets all the squares of the board to `Player.empty`
    func resetGame(enableNPC:Bool) {
        self.isNPCEnabled = enableNPC
        
        for n in (0 ..< self.rowSize * self.rowSize){
            board[n].status = .empty
        }
        
        //or reset the active player to X
        if isNPCEnabled && self.activePlayer == .o {
            makeNPCMove(player: .o)
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
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            return (isAwinner, winner)
        }else{
            let gameState = board.compactMap({$0.status})
            let hasAllItemsEqual = gameState.dropFirst().allSatisfy({ $0 != Player.empty })
            if hasAllItemsEqual {
                #if DEBUG
                print("🙅🏾 Draw!!!")
                #endif
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.warning)
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
