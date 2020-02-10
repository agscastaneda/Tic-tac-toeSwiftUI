//
//  TicTacToeModel.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 08/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import Foundation
import SwiftUI

class TicTacToeModel: ObservableObject{
    
    @Published var board = [SquareModel]()
    
    init(rowSize: Int) {
        for _ in (0 ..< rowSize * rowSize){
            board.append(SquareModel())
        }
    }
    
    func resetGame() {
//        TODO: Reset all squares to empty
    }
    
    func checkForWinner(){
//        TODO: Check if there is a winner or draw
    }
}

struct Definitions {
    let lines: Int = 3
    let winPatterns = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
}


enum Player {
    case o
    case x
    case empty
    
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

