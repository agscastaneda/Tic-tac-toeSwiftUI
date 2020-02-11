//
//  SquareView.swift
//  Tic-Tac-Toe
//
//  Created by Agustin Castaneda on 11/02/20.
//  Copyright © 2020 Agustin Castaneda. All rights reserved.
//

import SwiftUI

struct SquareView: View {
    @ObservedObject var source: SquareModel
    var action: () -> Void
    var body: some View {
        xoImageView(player: source.status)
            .gesture(TapGesture().onEnded({ () in
            self.action()
        }))
    }
}
