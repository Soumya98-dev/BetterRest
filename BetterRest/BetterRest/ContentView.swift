//
//  ContentView.swift
//  BetterRest
//
//  Created by Soumyadeep Chatterjee on 10/21/24.
//

import SwiftUI

struct ContentView: View {
    //State variables for when to wake up, sleep amount and coffee amount
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationStack {
            VStack {
                Text("When do you want to wake up?")
                    .font(.headline)
                DatePicker(
                    "Please enter a time", selection: $wakeUp,
                    displayedComponents: .hourAndMinute
                )
                .labelsHidden()
                Text("Desired amount of sleep")
                    .font(.headline)
                Stepper(
                    "\(sleepAmount.formatted()) hours", value: $sleepAmount,
                    in: 4...12, step: 0.25)
                Text("Daily Coffee Intake")
                    .font(.headline)
                Stepper(
                    "\(coffeeAmount) cup(s)", value: $coffeeAmount, in: 1...20)
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        }

    }

    func calculateBedTime() {

    }
}

#Preview {
    ContentView()
}
