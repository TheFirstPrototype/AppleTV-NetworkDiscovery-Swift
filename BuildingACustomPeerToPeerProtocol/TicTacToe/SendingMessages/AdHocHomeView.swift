//
//  AdHocHomeView.swift
//  SendingMessages
//
//  Created by Saamer Admin on 12/24/22.
//  Copyright © 2022 Apple. All rights reserved.
//
import SwiftUI
import DeviceDiscoveryUI

struct AdHocHomeView: View {
    @State var listener: NWListener?
    @State var connection:NWConnection?
    @State var nwEndpoint:NWEndpoint?
    @State var initiatedConnection:Bool = false
    @AppStorage("IsDevicePickerActive") var isDevicePickerActive:Bool = false
    @State var firstPlayer:NWEndpoint = NWEndpoint.unix(path: "")
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
                Spacer()
                Text("Play using your Apple TV remote only")
                Button{
                    Task{
                        print("Do work here")
                        //                        TODO: Undo this
                        //                        isDevicePickerActive = true
                        isDeviceConnected = true
                    }
                }label:{
                    Text("Start AdHoc Game")
                }
                Spacer()
//                Button("Search for device", role: .none, action: { print("H")})
                //                    .disabled(!isDeviceConnected)
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
