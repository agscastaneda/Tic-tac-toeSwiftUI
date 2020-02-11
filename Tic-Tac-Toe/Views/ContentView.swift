//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 06/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var boardModel = TicTacToeModel(rowSize: Definitions().lines)
    @State private var isGameOver = false

    func getIndex(row:Int, col:Int)-> Int{
        return row * Definitions().lines + col
    }
    
    func squareAction(index:Int){
        self.boardModel.makeMove(index: index, player: self.boardModel.activePlayer)
    }
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
                                    SquareView (source: self.$boardModel.board[self.getIndex(row: row, col: col)]){
                                        let index = self.getIndex(row: row, col: col)
                                        self.squareAction(index: index)
                                    }
                                }
                            
                            }
                        }
                    }
                }.aspectRatio(1, contentMode: .fit)
                .padding(20)
            }
            CurrentPlayerView(currentPlayer: self.boardModel.activePlayer)
            Spacer()
            Button(action: {
                self.boardModel.resetGame()
            }) {
                Text("Restart game!")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.horizontal)
            }
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
    @Binding var source: SquareModel
    var action: () -> Void
    var body: some View {
        xoImageView(player: source.status)
            .gesture(TapGesture().onEnded({ () in
            self.action()
        }))
    }
}
