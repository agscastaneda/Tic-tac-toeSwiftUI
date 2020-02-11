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

final class TicTacToeModel: ObservableObject{
    
    @Published var board = [SquareModel]()
    @Published var activePlayer = Player.x
    
    private let rowSize:Int
    
    init(rowSize: Int) {
        self.rowSize = rowSize
        for _ in (0 ..< self.rowSize * self.rowSize){
            board.append(SquareModel(status: .empty))
        }
    }
    
    func makeMove(index: Int, player:Player) /*-> Bool*/ {
        if board[index].status == .empty {
            print("✅ The Square is empty")
            board[index].status = player
            print("Square \(index) set to \(board[index].status)")
            self.changePlayer()
        }else{
           print("🚫 Square \(index) alredy filled with: \(board[index].status) ")
        }
    }

    
    func resetGame() {
        for n in (0 ..< self.rowSize * self.rowSize){
            board[n].status = .empty
        }
    }
    
    func changePlayer (){
        switch self.activePlayer {
        case .x:
            self.activePlayer = .o
         case .o:
           self.activePlayer = .x
        case .empty:
            break
        }
        let isGameOver = self.isGameOver()
        if isGameOver {
            print("👾 Game Over!!")
            resetGame()
        }
    }
    
    func isGameOver() -> Bool {
         let isAwinner = checkForWinner()
            print("❗️ isAwinner: \(isAwinner)")
        if isAwinner {
            return true
        }else{
            let gameState = board.compactMap({$0.status})
            let hasAllItemsEqual = gameState.dropFirst().allSatisfy({ $0 != Player.empty })
            if hasAllItemsEqual {
                print("🙅🏾 Draw!!!")
                return true
            }
        }
        
        return false
    }
    
    func checkForWinner() -> Bool{
        let gameState = board.compactMap({$0.status})
        print("📏\(gameState)")
        for combinations in Definitions().winPatterns{
            if gameState[combinations[0]] != Player.empty && gameState[combinations[0]] == gameState[combinations[1]] &&  gameState[combinations[1]] == gameState[combinations[2]]{
                if gameState[combinations[0]] == Player.x{
                    print("🎉 ❌ has won!")
                }else{
                    print("🎉 ⭕️ has won!")
                }
                return true
            }
        }
        return false
    }
}

//struct Square{
//    @State var status: Player
//}


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
            return ""
        }
    }
}
