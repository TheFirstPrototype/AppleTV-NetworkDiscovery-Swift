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
    @State var listener: NWListener?
    @State var connection:NWConnection?
    @State var nwEndpoint:NWEndpoint?
    @State var initiatedConnection:Bool = false
    @AppStorage("IsDevicePickerActive") var isDevicePickerActive:Bool = false
    var body: some View {
        if isDevicePickerActive{
            DevicePicker(.applicationService(name: "TicTacToe")) { endpoint in
                print(endpoint)
                let nwConnection = NWConnection(to: endpoint, using: applicationServiceParameters())
                connection = nwConnection
                initiatedConnection = true
                startConnection()

//                myDeviceManager.connectTo(endpoint: endpoint)
            } label: {
                Text("Connect to a local device.")
            } fallback: {
                Text("Not supported.")
            } parameters: {
                // This example uses the default application services parameters;
                // however, you can add a NWProtocolFramer to provide application-level
//                 messaging.
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
    
    func receiveNextMessage() {
        guard let connection = connection else {
            return
        }
        print("passed connection guard")
        let message = NWProtocolFramer.Message(gameMessageType: .move)
        let context = NWConnection.ContentContext(identifier: "Move",
                                                  metadata: [message])
        let character = "🙈"
        let column = 1
        let row = 1
        let move = String("\(character),\(column),\(row)")

        connection.send(content: move.data(using: .unicode), contentContext: context, isComplete: true, completion: .idempotent)
        connection.receiveMessage { (content, context, isComplete, error) in
            // Extract your message type from the received context.
            print("Extraction")
            if let gameMessage = context?.protocolMetadata(definition: GameProtocol.definition) as? NWProtocolFramer.Message {
                print(content)
                print(gameMessage)
//                self.delegate?.receivedMessage(content: content, message: gameMessage)
            }
            if error == nil {
                // Continue to receive more messages until you receive an error.
                self.receiveNextMessage()
            }
        }
    }

    func startConnection() {
        guard let nwConnection = connection else {
            return
        }
        do {
            listener = try NWListener(using: applicationServiceParameters())
            //             let listener = try NWListener(using: NWParameters(passcode: passcode))
        }
        catch{
            print("listener issues")
        }
        listener?.service = NWListener.Service(applicationService: "TicTacToe")
//        listener?.service = NWListener.Service(name: "TicTacToe", type: "_tictactoe._tcp")
        listener?.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("\(connection) established in listener")

                // When the connection is ready, start receiving messages.
                receiveNextMessage()

                // Notify the delegate that the connection is ready.
//                    delegate.connectionReady()
//         navigationController?.performSegue(withIdentifier: "showGameSegue", sender: nil)

            case .failed(let error):
                print("\(connection) failed with \(error)")

                // Cancel the connection upon a failure.
                connection?.cancel()

                if let endpoint = nwEndpoint,
                   initiatedConnection && error == NWError.posix(.ECONNABORTED) {
                    // Reconnect if the user suspends the app on the nearby device.
                    let nwConnection = NWConnection(to: endpoint, using: applicationServiceParameters())
                    connection = nwConnection
                    startConnection()
                } else {
                    // Notify the delegate when the connection fails.
                    connectionFailed()
                }
            default:
                print("Default")
                break
            }
        }
        print("Passes guard")

        connection!.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("\(connection) established")

                // When the connection is ready, start receiving messages.
                receiveNextMessage()

                // Notify the delegate that the connection is ready.
//                    delegate.connectionReady()

            case .failed(let error):
                print("\(connection) failed with \(error)")

                // Cancel the connection upon a failure.
                connection?.cancel()

                if let endpoint = nwEndpoint,
                   initiatedConnection && error == NWError.posix(.ECONNABORTED) {
                    // Reconnect if the user suspends the app on the nearby device.
                    let nwConnection = NWConnection(to: endpoint, using: applicationServiceParameters())
                    connection = nwConnection
                    startConnection()
                } else {
                    // Notify the delegate when the connection fails.
                    connectionFailed()
                }
            default:
                print("Default")
                break
            }
        }

        // Start the connection establishment.
        connection!.start(queue: .main)
    }
    
    func connectionFailed() {
        stopGame()
    }
    
    func stopGame(){
        print("Stop Game")
        if let sharedConnection = sharedConnection {
            sharedConnection.cancel()
        }
        sharedConnection = nil
//        dismiss(animated: true, completion: nil)
        isDevicePickerActive = true
    }
    
    func receivedMessage(content: Data?, message: NWProtocolFramer.Message) {
        guard let content = content else {
            return
        }
        switch message.gameMessageType {
        case .invalid:
            print("Received invalid message")
        case .selectedCharacter:
            print("handleSelectCharacter(content,message)")
//            handleSelectCharacter(content, message)
        case .move:
            print("handleMove(content, message)")
//            handleMove(content, message)
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
