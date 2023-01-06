//
//  GameView.swift
//  SendingMessages
//
//  Created by Saamer Admin on 12/23/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import SwiftUI

struct GameView: View {
    @AppStorage("IsDeviceConnected") var isDeviceConnected = false
    @State var isGameWon = false
    @State var winner : Player = .one
    @State var turn : Player = .one
    @State var playState:GameState = GameState(the0X0: "", the0X1: "", the0X2: "", the1X0: "", the1X1: "", the1X2: "", the2X0: "", the2X1: "", the2X2: "")
//        TODO: UNCOMMENT this for fake game
//    @State var playState:GameState = GameState(the0X0: "x", the0X1: "o", the0X2: "", the1X0: "o", the1X1: "x", the1X2: "", the2X0: "o", the2X1: "x", the2X2: "x")
    init(){
        isGameWon = false
//        TODO: UNCOMMENT this for fake game
//        CheckGameStatus()
//        TODO: UNCOMMENT this for real game
        ClearAll()
    }
    var body: some View {
        VStack {
            HStack{
                Image("CrissCross")
                    .padding([.top, .leading], 50.0)
                Spacer()
                if (isGameWon) {
                    Text(winner == .one ? "Player 1 wins!" : "Player 2 wins!")
                        .font(.title2)
                    Spacer()
                }
            }
            Spacer()
//            Text("Device not supported")
            HStack{
                Spacer()
                ZStack{
                    VStack(alignment: .trailing){
                        Rectangle()
                            .fill(.red)
                            .frame(width: 500, height: 10.0)
                            .padding(80)
                        Rectangle()
                            .fill(.red)
                            .frame(width: 500, height: 10.0)
                            .padding(80)
                    }
                    HStack(alignment: .bottom){
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 10.0, height: 500)
                            .padding(40)
                        Rectangle()
                            .fill(.blue)
                            .frame(width: 10.0, height: 500)
                            .padding(40)
                    }
                    Grid(alignment: .topTrailing) {
                        GridRow {
                            // if there's no value in that array element already, make that location a button that can be tapped
                            if playState.the0X0 == ""{
                                Button("", action: {
                                    playState.the0X0 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the0X0)
                                    .font(.headline)
                                    .padding()
                            }
                            if playState.the0X1 == ""{
                                Button("", action: {
                                    playState.the0X1 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the0X1)
                                    .font(.headline)
                                    .padding()
                            }
                            if playState.the0X2 == ""{
                                Button("", action: {
                                    playState.the0X2 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the0X2)
                                    .font(.headline)
                                    .padding()
                            }
                        }
                        .padding()
                        Divider()
                            .gridCellUnsizedAxes(.horizontal)
                        GridRow(alignment: .top) {
                            if playState.the1X0 == ""{
                                Button("", action: {
                                    playState.the1X0 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the1X0)
                                    .font(.headline)
                                    .padding()
                            }
                            if playState.the1X1 == ""{
                                Button("", action: {
                                    playState.the1X1 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the1X1)
                                    .font(.headline)
                                    .padding()
                            }
                            if playState.the1X2 == ""{
                                Button("", action: {
                                    playState.the1X2 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the1X2)
                                    .font(.headline)
                                    .padding()
                            }
                        }
                        .padding()
                        Divider()
                            .gridCellUnsizedAxes(.horizontal)
                        GridRow {
                            if playState.the2X0 == ""{
                                Button("", action: {
                                    playState.the2X0 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the2X0)
                                    .font(.headline)
                                    .padding()
                            }
                            if playState.the2X1 == ""{
                                Button("", action: {
                                    playState.the2X1 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the2X1)
                                    .font(.headline)
                                    .padding()
                            }
                            if playState.the2X2 == ""{
                                Button("", action: {
                                    playState.the2X2 = PopulateValue()
                                    CheckGameStatus()
                                })
                                .padding()
                            } else {
                                Text(playState.the2X2)
                                    .font(.headline)
                                    .padding()
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            Spacer()
            HStack{
                if (!isGameWon){
                    Text(turn == Player.one ? "Turn: Player 1 - crosses" : "Turn: Player 2 - circles")
                    Spacer()
                    Button{
                        Task{
                            print("Do work here")
                            isDeviceConnected = false
                        }
                    }label:{
                            Text("Cancel Game")
                    }
                } else{
                    Button{
                        Task{
                            print("Retry")
                            ClearAll()
                        }
                    }label:{
                        Text("Retry")
                    }
                    Button{
                        Task{
                            print("Home")
                            isDeviceConnected = false
                        }
                    }label:{
                        Text("Home")
                    }
                }
            }
        }
        .padding()
        
    }
    
    func ClearAll(){
        playState.the0X0 = ""
        playState.the0X1 = ""
        playState.the0X2 = ""
        playState.the1X0 = ""
        playState.the1X1 = ""
        playState.the1X2 = ""
        playState.the2X0 = ""
        playState.the2X1 = ""
        playState.the2X2 = ""
        CheckGameStatus()
        isGameWon = false
    }
    
    func PopulateValue() -> String {
        if turn == .one{
            turn = .two
            return "x"
        } else {
            turn = .one
            return "o"
        }
    }
    func CheckGameStatus(){
        //        Winning Moves:
        //            [ [ (0, 0), (0, 1), (0, 2) ],
        //              [ (0, 0), (1, 0), (2, 0) ],
        //              [ (0, 0), (1, 1), (2, 2) ],
        //
        //              [ (0, 2), (1, 2), (2, 2) ],
        //              [ (2, 0), (2, 1), (2, 2) ],
        //
        //              [ (1, 0), (1, 1), (1, 2) ],
        //              [ (0, 1), (1, 1), (2, 1) ],
        //              [ (2, 0), (1, 1), (0, 2) ] ]
        if (((playState.the0X0 == playState.the0X1) && (playState.the0X1 == playState.the0X2) ||
            (playState.the0X0 == playState.the1X0) && (playState.the1X0 == playState.the2X0) ||
            (playState.the0X0 == playState.the1X1) && (playState.the1X1 == playState.the2X2)) && playState.the0X0 != ""){
            isGameWon = true
            if (playState.the0X0 == "x"){
                // Player 1 is x
                winner = .one
            } else {
                winner = .two
            }
            TurnEmptyButtonsIntoLabels()
        } else if
            (((playState.the0X2 == playState.the1X2) && (playState.the1X2 == playState.the2X2) ||
             (playState.the2X0 == playState.the2X1) && (playState.the2X1 == playState.the2X2)) && playState.the2X2 != ""){
            isGameWon = true
            if (playState.the2X2 == "x"){
                // Player 1 is x
                winner = .one
            } else {
                winner = .two
            }
            TurnEmptyButtonsIntoLabels()
        } else if
            (((playState.the1X0 == playState.the1X1) && (playState.the1X1 == playState.the1X2) ||
            (playState.the0X1 == playState.the1X1) && (playState.the1X1 == playState.the2X1) ||
            (playState.the2X0 == playState.the1X1) && (playState.the1X1 == playState.the0X2)) && playState.the1X1 != ""){
            isGameWon = true
            if (playState.the1X1 == "x"){
                // Player 1 is x
                winner = .one
            } else {
                winner = .two
            }
            TurnEmptyButtonsIntoLabels()
        }
    }
    
    func TurnEmptyButtonsIntoLabels()
    {
        if(playState.the0X0 == ""){ playState.the0X0 = " "}
        if(playState.the0X1 == ""){ playState.the0X1 = " "}
        if(playState.the1X0 == ""){ playState.the1X0 = " "}
        if(playState.the1X1 == ""){ playState.the1X1 = " "}
        if(playState.the0X2 == ""){ playState.the0X2 = " "}
        if(playState.the2X0 == ""){ playState.the2X0 = " "}
        if(playState.the2X2 == ""){ playState.the2X2 = " "}
        if(playState.the2X1 == ""){ playState.the2X1 = " "}
        if(playState.the1X2 == ""){ playState.the1X2 = " "}
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

enum Player{
    // Player 1 is x
    case one, two
}
enum Play{
    // Player 1 is x
    case x, o, empty
}

struct PlayState: Identifiable, Hashable {
    let id = UUID()
    let play: [[Play]]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
