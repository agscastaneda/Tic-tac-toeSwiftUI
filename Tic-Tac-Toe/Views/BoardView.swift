//
//  BoardView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 08/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct BoardView: View {
    
    var boardLength : Int?
    
    var body: some View {
        
        ZStack{
            //Start Grid
            VStack {
                Spacer()
                ForEach(0 ..< (boardLength ?? 3) - 1) { item in
                    line(color: Color.gray)
                    Spacer()
                }
            }//Vertical lines
            HStack {
                Spacer()
                ForEach(0 ..< (boardLength ?? 3) - 1) { item in
                    line(color: Color.gray)
                    Spacer()
                }
            }//Horizontal lines
            //End grid
            //            VStack {
            //                ForEach(0 ..< sqrMatrixLength ) { item in
            //                    HStack {
            //                        ForEach(0 ..< self.sqrMatrixLength) { item in
            //                            Image("nought")
            //                                .resizable()
            //                                .padding()
            //                        }
            //                    }
            //                }
            //            }//Images
        }//ZStack
            
            .padding(16)
            .aspectRatio(1, contentMode: .fit)
    }
}

struct line: View {
    
    var color:Color?
    
    var body: some View {
        Divider()
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(color ?? Color.gray, lineWidth: 5))
    }
}

struct xoImageView: View {
    @State var player: Player
    var body: some View {
        Image(player.imageName)
        .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
    }
}

struct Board_Previews: PreviewProvider {
    static var previews: some View {
        BoardView().previewLayout(.sizeThatFits)
    }
}
