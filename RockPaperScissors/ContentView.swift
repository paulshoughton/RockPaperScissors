//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Paul Houghton on 04/08/2020.
//  Copyright © 2020 Paul Houghton. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves: [String] = ["🧱Rock", "🧻Paper", "✂️Scissors"]
    @State private var move: Int = Int.random(in: 0...2)
    @State private var winOrLose: Bool = Bool.random()
    @State private var score = 0
    @State private var showingScore: Bool = false
    @State private var scoreTitle: String = ""
    @State private var scoreMessage: String = ""
        
    var body: some View {
        VStack {
            Text("Brain Training")
                .font(.largeTitle)
            Spacer()
            Text("You must \(winOrLose ? "Win" : "Lose") against \(possibleMoves[move])")
                .padding(.bottom, 40)
            HStack {
                ForEach(0..<self.possibleMoves.count) { number in
                    Button(action: {
                        self.buttonTapped(number: number)
                    }) {
                        Text("\(self.possibleMoves[number])")
                    }
                    .padding()
                    .background(Color(red: 0.9, green: 0.9 , blue: 0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            Spacer()
            HStack {
                Text("Score")
                Text("\(self.score)")
            }
            .padding( .bottom)
        }
        .alert(isPresented: $showingScore) {
            Alert(
                title: Text(scoreTitle),
                message: Text(scoreMessage),
                dismissButton: .default(Text("Next Question")) {
                    self.askQuestion()
                }
            )
        }
    }
    
    func buttonTapped(number: Int) {
        if rightOrWrong(number: number) {
            scoreTitle = "Correct. 😀"
            scoreMessage = "You scored 1 point."
            score += 1
        }
        else {
            scoreTitle = "Wrong. 😢"
            scoreMessage = "The correct answer was \(move)"
        }
        showingScore = true
    }
    
    func rightOrWrong(number: Int) -> Bool {
        
        switch move {
        case 0: //Rock
            if winOrLose == true && number == 1 { //Paper
                return true
            }
            else if winOrLose == false && number == 2 { //Scissors
                return true
            }
        case 1: //Paper
            if winOrLose == true && number == 2 { //Scissors
                return true
            }
            else if winOrLose == false && number == 0 { //Rock
                return true
            }
        case 2: //Scissors
            fallthrough
        default:
            if winOrLose == true && number == 0 { //Rock
                return true
            }
            else if winOrLose == false && number == 1 { //Paper
                return true
            }
        }
        
        return false
    }
    
    func askQuestion() {
        self.move = Int.random(in: 0...2)
        self.winOrLose = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
