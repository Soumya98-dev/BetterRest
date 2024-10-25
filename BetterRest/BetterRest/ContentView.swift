//
//  ContentView.swift
//  BetterRest
//
//  Created by Soumyadeep Chatterjee on 10/21/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    //State variables for when to wake up, sleep amount and coffee amount
    @State private var wakeUp = Date.now
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    //State variables to tell the user when to wake up
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

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
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }

    }

    func calculateBedTime() {
        do {
            //            Creates a configuration object
            //            MLModelConfiguration- Used to specify how the CoreML will be loaded; such as settings related to memory, precision and compute resources
            let config = MLModelConfiguration()
            //            'try' is used because SleepCalcualator might throw an error
            //            Errors like .mlmodel not found
            let model = try SleepCalculator(configuration: config)
            //            -> "Calendar.current" -> Refers to the users current calendar settings
            //            -> ".dateComponents(
            //            [.hour, .minute], from: wakeUp)" -> extracts specific date components from the wakeup variable like the hour and minute
            //            Suppose the wakeUp date is set to 7:30 AM:
            //            components.hour will be 7.
            //            components.minute will be 30.
            //            The calculation will be:
            //            Hour in seconds: 7 * 60 * 60 = 25200 seconds.
            //            Minute in seconds: 30 * 60 = 1800 seconds.
            //            So, the total number of seconds from midnight to 7:30 AM would be 25200 + 1800 = 27000 seconds.
            let components = Calendar.current.dateComponents(
                [.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            //The below line is using the Core ML model to make a prediction based on when the user wants to wake up
            let prediction = try model.prediction(
                wake: Double(hour + minute), estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount))

            //Calculates the sleepTime; optimal time for user to got to sleep
            let sleepTime = wakeUp - prediction.actualSleep

            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            //catches any error thrown by try SleepCalculator(configuration: config).
            alertTitle = "ERROR"
            alertMessage =
                "Something went wrong, while calculating your be time"

        }

        showingAlert = true
    }
}

#Preview {
    ContentView()
}
