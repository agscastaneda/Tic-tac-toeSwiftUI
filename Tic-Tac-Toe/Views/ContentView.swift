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
    @State var activePlayer = Player.x
    
    func getIndex(row:Int, col:Int)-> Int{
        return row * Definitions().lines + col
    }
    
    func squareAction(index:Int){
        self.boardModel.makeMove(index: index, player: self.boardModel.activePlayer)
        self.activePlayer = self.boardModel.activePlayer
        self.isGameOver = self.boardModel.isGameOver().isGameOver
        if self.isGameOver {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
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
                                    SquareView (source: self.boardModel.board[self.getIndex(row: row, col: col)]){
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
            CurrentPlayerView(currentPlayer: SquareModel(status: self.activePlayer))
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
            .onAppear{
                self.activePlayer = self.boardModel.activePlayer
        }
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("Game Over"), message: Text(self.boardModel.isGameOver().winner != Player.empty ? "\n\nPlayer \(self.boardModel.isGameOver().winner.string) Wins!" :"\n\nIt's a Draw 🙅🏾!" ), dismissButton: .default(Text("OK")){
                self.boardModel.resetGame()
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
