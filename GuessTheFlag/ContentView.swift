//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by artembolotov on 25.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingWrongAlert = false
    @State private var showingResultsAlert = false
    
    @State private var score = 0
    @State private var scoreMessage = ""
    @State private var currentQuestion = 1
    
    private let questionsCount = 8
    
    private var wrongDismissAction: () -> Void {
        currentQuestion == questionsCount ? showFinalDetails : askQuestion
    }
        
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
                    }
                    Text("Question \(currentQuestion) / \(questionsCount)")
                        .font(.footnote)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .universalBackground()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .universalAlert(isPresented: $showingWrongAlert, title: "Wrong", message: scoreMessage, dismissTitle: "Continue", dismissAction: wrongDismissAction)
        
        .universalAlert(isPresented: $showingResultsAlert, title: "Result", message: "Your score is \(score)", dismissTitle: "Reset the Game", dismissAction: resetGame)
    }
    
    func flagTapped(_ number: Int) {
        let isCorrect = number == correctAnswer
        
        score += isCorrect ? 1 : 0
        
        if !isCorrect {
            scoreMessage = "That's the flag of \(countries[number])"
            
            showingWrongAlert = true
        } else {
            if currentQuestion != questionsCount {
                askQuestion()
            } else {
                showFinalDetails()
            }
        }
    }
    
    func askQuestion() {
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
