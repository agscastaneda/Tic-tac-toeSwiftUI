//
//  SquareModel.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 09/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import Foundation


/// Model that represents a square of the board of TicTacToeModel
class SquareModel: ObservableObject{
    @Published var status: Player = .empty
    
    init(status: Player) {
        self.status = status
    }
}
