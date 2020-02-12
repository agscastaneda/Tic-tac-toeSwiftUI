//
//  CurrentPlayerView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 08/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct CurrentPlayerView: View {
    @ObservedObject var currentPlayer: SquareModel
    
    var body: some View {
        HStack {
            Text("Current Player: ")
                .font(Font.custom("JosefinSans-Regular", size: 20))
                .bold()
                xoImageView(player: currentPlayer.status)
                .frame(maxWidth: 40, maxHeight: 40)
        }
    }
}

// MARK: -
struct CurrentPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPlayerView(currentPlayer: SquareModel(status: .x)).previewLayout(.sizeThatFits)
    }
}
