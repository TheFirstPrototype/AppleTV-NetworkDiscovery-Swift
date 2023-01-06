//
//  AdHocHomeView.swift
//  TicTacToe
//
//  Created by Saamer Admin on 1/6/23.
//  Copyright © 2023 Apple. All rights reserved.
//

import SwiftUI

struct AdHocHomeView: View {
    @AppStorage("IsDeviceConnected") var isDeviceConnected = false
    var body: some View {
        if isDeviceConnected{
            GameView()
        } else {
            VStack {
                HStack{
                    Image("CrissCross")
                        .padding([.top, .leading], 50.0)
                    Spacer()
                }
                Text("This app works best with a friend and an Apple TV running tvOS 16 in multiplayer mode, or you can practice while you wait")

                Spacer()
                Text("Play using your iPhone only")
                Button{
                    Task{
                        print("Do work here")
                        isDeviceConnected = true
                    }
                }label:{
                    Text("Start AdHoc Game")
                }
                Spacer()
                Text("Waiting for Apple TV connection...")
            }
            .padding()
        }
    }
}

struct AdHocHomeView_Previews: PreviewProvider {
    static var previews: some View {
        AdHocHomeView()
    }
}
