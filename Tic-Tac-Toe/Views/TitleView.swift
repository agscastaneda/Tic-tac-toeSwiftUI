//
//  TitleView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 08/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    var body: some View {
        VStack{
            HStack{
                xoImageView(player: Player.o)
                    .frame(maxWidth: 50)
                xoImageView(player: Player.x)
                    .frame(maxWidth: 70)
                xoImageView(player: Player.o)
                    .frame(maxWidth: 50)
            }
            Text("Tic-Tac-Toe")
                .font(Font.custom("JosefinSans-Regular", size: 50))
                .bold()}
    }
}
// MARK: -
struct TilteView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView().previewLayout(.sizeThatFits)
    }
}
