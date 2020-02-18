//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 06/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI


/// Main view of Game
struct ContentView: View {
    
    @State var boardModel = TicTacToeModel(rowSize: Definitions().lines, enableAI: true) // Here we create the board
    @State private var isGameOver = false
    @State var activePlayer = Player.x
    @State var isNPCEnable = true
    
    func getIndex(row:Int, col:Int)-> Int{
        return row * Definitions().lines + col
    }
    
    func squareAction(index:Int){
        self.boardModel.makeMove(index: index, player: self.boardModel.activePlayer)
        
        self.isGameOver = self.boardModel.isGameOver().isGameOver
        
        if(!self.isGameOver && self.boardModel.activePlayer == .o){
            self.boardModel.makeNPCMove(player: .o)
            self.isGameOver = self.boardModel.isGameOver().isGameOver
        }else{
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        self.activePlayer = self.boardModel.activePlayer
    }
    var body: some View {
        
        VStack {
            Spacer()
            TitleView()
            Text("The NPC is: \(self.isNPCEnable ? "ON": "OFF")")
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
                self.boardModel.resetGame(enableNPC: self.isNPCEnable)
            }) {
                Text("Restart game!")
                    .font(.system(size: 30))
                    .fontWeight(.heavy)
                    .padding(.horizontal)
            }
            Divider()
            HStack{
                Button(action: {
                    self.isNPCEnable = false
                    self.boardModel.resetGame(enableNPC:  self.isNPCEnable)
                    self.activePlayer = self.boardModel.activePlayer
                }) {
                    Text("1P vs 2P")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                }
                Button(action: {
                    self.isNPCEnable = true
                    self.boardModel.resetGame(enableNPC:  self.isNPCEnable)
                    self.activePlayer = self.boardModel.activePlayer
                }) {
                    Text("1P vs Phone")
                        .font(.system(size: 20))
                        .fontWeight(.heavy)
                        .padding(.horizontal)
                }
            }
            
            Spacer()
        }.padding(.horizontal)
            .onAppear{
                self.activePlayer = self.boardModel.activePlayer
        }
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("Game Over"), message: Text(self.boardModel.isGameOver().winner != Player.empty ? "\n\nPlayer \(self.boardModel.isGameOver().winner.string) Wins!" :"\n\nIt's a Draw 🙅🏾!" ), dismissButton: .default(Text("OK")){
                self.boardModel.resetGame(enableNPC: self.isNPCEnable)
                self.activePlayer = self.boardModel.activePlayer
                })
        }
    }
}
// MARK: -
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
