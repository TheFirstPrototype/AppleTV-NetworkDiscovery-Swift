//
//  GameState.swift
//  SendingMessages
//
//  Created by Saamer Admin on 12/24/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct GameState: Codable {
    var the0X0, the0X1, the0X2, the1X0: String
    var the1X1, the1X2, the2X0, the2X1: String
    var the2X2: String

//    enum CodingKeys: String, CodingKey {
//        case the0X0 = "0x0"
//        case the0X1 = "0x1"
//        case the0X2 = "0x2"
//        case the1X0 = "1x0"
//        case the1X1 = "1x1"
//        case the1X2 = "1x2"
//        case the2X0 = "2x0"
//        case the2X1 = "2x1"
//        case the2X2 = "2x2"
//    }
}
