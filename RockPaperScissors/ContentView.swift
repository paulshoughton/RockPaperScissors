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
        let answer = getAnswer()
        if answer == number {
            scoreTitle = "Correct. 😀"
            scoreMessage = "You scored 1 point."
            score += 1
        }
        else {
            scoreTitle = "Wrong. 😢"
            scoreMessage = "The correct answer was \(possibleMoves[answer])"
        }
        showingScore = true
    }
    
    func getAnswer() -> Int {
        switch move {
        case 0: //Rock - Win = Paper, Lose = Scissors
            return winOrLose ? 1 : 2
        case 1: //Paper - Win = Scissors, Lose = Rock
            return winOrLose ? 2 : 0
        case 2: //Scissors - Win = Rock, Lose = Paper
            fallthrough
        default:
            return winOrLose ? 0 : 1
        }
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
