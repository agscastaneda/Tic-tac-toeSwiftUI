//
//  SquareModel.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 09/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import Foundation

 class SquareModel: ObservableObject{
     @Published var status: Player = .empty
    
    init(status: Player) {
        self.status = status
    }
}
