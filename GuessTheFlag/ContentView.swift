//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by artembolotov on 25.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingResultsAlert = false
    
    @State private var score = 0
    @State private var currentQuestion = 1
    
    @State private var selectedFlag: Int? = nil
    
    private let questionsCount = 8
        
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Question \(currentQuestion) / \(questionsCount)")
                            .font(.footnote)
                            .padding()
                        Text("Tap on flag of")
                            .universalForegroundStyle()
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(selectedFlag == nil ? 1 : (number == selectedFlag ? 1 : 0.25))
                        .scaleEffect(selectedFlag == nil ? 1 : (number == selectedFlag ? 1 : 0.8))
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .universalBackground()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                if let selected = selectedFlag {
                    let message = selected == correctAnswer ? "You are right!" : "Wrong! That's the flag of \(countries[selected])"
                    VStack {
                        Text(message)
                            .foregroundColor(selectedFlag == correctAnswer ? .green : .red)
                        
                        if currentQuestion != questionsCount {
                            Button("Next Question") {
                                askQuestion()
                            }
                        } else {
                            Button("Restart the game") {
                                resetGame()
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .universalBackground()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .transition(.slide)
                }
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
            }
            .padding()
            .preferredColorScheme(.dark)
        }
    }
    
    func flagTapped(_ number: Int) {
        guard selectedFlag == nil else { return }
        withAnimation {
            selectedFlag = number
        }
        
        let isCorrect = number == correctAnswer
        score += isCorrect ? 1 : 0
    }
    
    func askQuestion() {
        withAnimation {
            selectedFlag = nil
        }
        currentQuestion += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame() {
        currentQuestion = 0
        score = 0
        askQuestion()
    }
    
    func showFinalDetails() {
        showingResultsAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
