//
//  CurrentPlayerView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 08/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct CurrentPlayerView: View {
    var currentPlayer: Player
    
    var body: some View {
        HStack {
            Text("Current Player: ")
                .font(Font.custom("JosefinSans-Regular", size: 20))
                .bold()
            Image(currentPlayer.imageName)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(maxWidth: 25, maxHeight: 25)
        }
    }
}

struct CurrentPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentPlayerView(currentPlayer: Player.x).previewLayout(.sizeThatFits)
    }
}
