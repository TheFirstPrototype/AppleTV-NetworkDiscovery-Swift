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
        let devicePicker = DDDevicePickerViewController(browseDescriptor: .applicationService(name: "TicTacToe"),
                                                              parameters: applicationServiceParameters())
        self.viewController = devicePicker!
    }

    public func makeUIViewController(context: Context) -> DDDevicePickerViewController {
        let gkVC = viewController
        return gkVC
    }

    public func updateUIViewController(_ uiViewController: DDDevicePickerViewController, context: Context) {
        return
    }

}
