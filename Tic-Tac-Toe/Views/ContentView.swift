//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 06/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var boardModel = TicTacToeModel(rowSize: Definitions().lines)

    var body: some View {
        
         VStack {
            Spacer()
            TitleView()
            ZStack{
                BoardView()
                VStack{
                    ForEach(0..<Definitions().lines) { row in
                        HStack {
                            ForEach(0..<Definitions().lines) { col in
                                ZStack{
                                    SquareView {
                                        print("Index pressed: \(row * Definitions().lines + col )")
                                    }
                                }
                            
                            }
                        }
                    }
                }.aspectRatio(1, contentMode: .fit)
                .padding(20)
                
            }
            CurrentPlayerView(currentPlayer: Player.o)
            Spacer()
        }.padding(.horizontal)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SquareView: View {
    var action: () -> Void
    var body: some View {
            xoImageView(player: .o)
            .gesture(TapGesture().onEnded({ () in
            self.action()
        }))
    }
}
