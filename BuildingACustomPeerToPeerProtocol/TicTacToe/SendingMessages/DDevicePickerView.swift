//
//  DDevicePickerView.swift
//  SendingMessages
//
//  Created by Saamer Admin on 12/3/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation
import GameKit
import SwiftUI
import DeviceDiscoveryUI

public struct DDevicePickerView: UIViewControllerRepresentable {
    let viewController: DDDevicePickerViewController
    @AppStorage("IsDevicePickerActive") var isDevicePickerActive:Bool = false

    public init() {
        // Create the view controller for the device picker.
//        guard let devicePicker = DDDevicePickerViewController(browseDescriptor: .applicationService(name: "TicTacToe"),
//                                                              parameters: applicationServiceParameters()) else {
//            print("Could not create device picker.")
//            return
//        }
        let devicePicker = DDDevicePickerViewController(browseDescriptor: .applicationService(name: "TicTacToe"),
                                                              parameters: applicationServiceParameters())
        self.viewController = devicePicker!
//        let endpoint = try await devicePicker!.endpoint
    }

    public func makeUIViewController(context: Context) -> DDDevicePickerViewController {
        let gkVC = viewController
//        gkVC.gameCenterDelegate = context.coordinator
        return gkVC
    }

    public func updateUIViewController(_ uiViewController: DDDevicePickerViewController, context: Context) {
        return
    }

//    public func makeCoordinator() -> GKCoordinator {
//        return GKCoordinator(self)
//    }
}
//
//public class GKCoordinator: NSObject, DDevicePickerViewControllerDelegate {
//    var view: GameCenterView
//
//    init(_ gkView: GameCenterView) {
//        self.view = gkView
//    }
//
//    public func devicePickerViewControllerDidFinish(_ devicePickerViewController: DDDevicePickerViewController) {
//        devicePickerViewController.dismiss(animated: true, completion: nil)
//        view.isGKActive = false
//    }
//}
