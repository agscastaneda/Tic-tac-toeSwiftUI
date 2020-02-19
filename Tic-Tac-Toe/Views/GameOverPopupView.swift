//
//  GameOverPopupView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 18/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct GameOverPopupView: View {
    @Binding var showPopup: Bool
    @Binding var winner: Player
    var action: () -> Void
    var body: some View {
        ZStack{
            ZStack{
                if showPopup {
                    VStack{
                        Text("Game Over")
                           .font(Font.custom("JosefinSans-Regular", size: 30))
                           .bold()
                           .padding(.horizontal)

                        Text("\n")
                        
                        HStack {
                            if self.winner != Player.empty {
                                Text("Player")
                                .font(Font.custom("JosefinSans-Regular", size: 20))
                                 xoImageView(player: self.winner)
                                .frame(maxWidth: 35, maxHeight: 35)
                                Text("Wins!!")
                            }else{
                                xoImageView(player: .x)
                                .frame(maxWidth: 35, maxHeight: 35)
                                Text("It's a Draw!")
                                .font(Font.custom("JosefinSans-Regular", size: 20))
                                xoImageView(player: .o)
                                .frame(maxWidth: 35, maxHeight: 35)
                            }
                        }
                         Text("\n")
                        Divider()
                        Button("Dismiss"){
                            withAnimation {
                                self.showPopup = false
                                self.action()
                            }
                            
                        }
                    }
                    .padding()
                }
            }
            .background(Blur())
            .cornerRadius(10)
        }
    }
}

//struct GameOverPopupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameOverPopupView(showPopup: true, winner: .x, action:{}).previewLayout(.sizeThatFits)
//    }
//}


// MARK: - Blur Effect
//https://gist.github.com/edwurtle/98c33bc783eb4761c114fcdcaac8ac71#file-blur-swift
struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
