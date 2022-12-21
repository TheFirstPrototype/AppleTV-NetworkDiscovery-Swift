//
//  ContentView.swift
//  SendingMessages
//
//  Created by Saamer Admin on 12/3/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import SwiftUI
import DeviceDiscoveryUI

struct ContentView: View {
    @AppStorage("IsDevicePickerActive") var isDevicePickerActive:Bool = false
    var body: some View {
        if isDevicePickerActive{
            DevicePicker(.applicationService(name: "TicTacToe")) { endpoint in
                print(endpoint)
//                myDeviceManager.connectTo(endpoint: endpoint)
            } label: {
                Text("Connect to a local device.")
            } fallback: {
                Text("Not supported.")
            } parameters: {
                // This example uses the default application services parameters;
                // however, you can add a NWProtocolFramer to provide application-level
                // messaging.
                .applicationService
            }

        } else {
            VStack {
                Text("Hello, world!")
                Button{
                    Task{
                        print("Do work here")
                        try await hostGameButton()
                    }
                }label:{
                    Text("Search")
                }
            }
            .padding()
        }
    }
    func hostGameButton() async {
        // Check to see whether the device supports DDDevicePickerViewController.
        guard await DDDevicePickerViewController.isSupported(.applicationService(name: "TicTacToe"),
                                                                           using: applicationServiceParameters()) else {
            print("This device does not support DDDevicePickerViewController.")
            return
        }
        isDevicePickerActive = true
        // Create the view controller for the device picker.
//        guard let devicePicker = await DDDevicePickerViewController(browseDescriptor: .applicationService(name: "TicTacToe"),
//                                                              parameters: applicationServiceParameters()) else {
//            print("Could not create device picker.")
//            return
//        }
//        
        // Show the network device picker as a full-screen, modal view.
//        self.present(devicePicker, animated: true)
        
        do {
            // Receive an endpoint asynchronously.
//            let endpoint = try await devicePicker.endpoint
//            sharedConnection = PeerConnection(endpoint: endpoint, delegate: self)
       } catch let error {
           // Handle any errors.
           print("There was an error with the endpointPicker: \(error)")
       }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
