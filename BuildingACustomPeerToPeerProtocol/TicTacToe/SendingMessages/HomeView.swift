//
//  HomeView.swift
//  SendingMessages
//
//  Created by Saamer Admin on 12/23/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import SwiftUI
import DeviceDiscoveryUI

struct HomeView: View {
    @State var showDevicePicker = false
    @State var playerOne = "?"
    @State var playerTwo = "?"
    var body: some View {
        VStack{
            VStack {
                Text("Player one: \(playerOne)")
                Text("Player two: \(playerTwo)")
                Button("Select Player") {
                    showDevicePicker = true
                }
            }
            .padding()
            .fullScreenCover(isPresented: $showDevicePicker) {
                // Display the device picker view.
                DevicePicker(.applicationService(name: "TicTacToe")) { endpoint in
                    if (playerOne == "?"){
                        playerOne = endpoint.debugDescription
                    } else {
                        playerTwo = endpoint.debugDescription
                    }
                    print(endpoint)
                    //                    myDeviceManager.connectTo(endpoint: endpoint)
                } label: {
                    Text("Add a player")
                } fallback: {
                    Text("Not supported.")
                } parameters: {
                    // This example uses the default application services parameters;
                    // however, you can add an NWProtocolFramer to provide application-level
                    // messaging.
                    .applicationService
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
