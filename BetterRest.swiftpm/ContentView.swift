import CoreML
import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = "Your ideal bedtime is…"
    private var alertMessage: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Sorry, there was a problem calculating your bedtime."
        }
    }
    @State private var showingAlert = false
    
    
    
    //    func calculateBedtime() {
    //        do {
    //            let config = MLModelConfiguration()
    //            let model = try SleepCalculator(configuration: config)
    //
    //            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
    //            let hour = (components.hour ?? 0) * 60 * 60
    //            let minute = (components.minute ?? 0) * 60
    //
    //            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
    //
    //            let sleepTime = wakeUp - prediction.actualSleep
    //
    //            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
    //
    //        } catch {
    //            alertMessage = "Sorry, there was a problem calculating your bedtime."
    //        }
    //    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Form {
                    Section("When Do you want to wake up?") {
                        DatePicker("Please select a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    }
                    
                    Section("Desired Amount of Sleep?") {
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                    
                    Section("Daily Coffee Intake?") {
                        Picker("Number of Cup(s)", selection: $coffeeAmount) {
                            ForEach(1..<21) { cups in
                                Text(cups == 1 ? "1 cup" : "\(cups) cups")
                            }
                        }
                    }
                    
                    
                }
                .navigationTitle("BetterRest")
                
                
                VStack {
                    Spacer()
                    Spacer()
                    Text(alertTitle)
                        .font(.largeTitle)
                        .padding()
                    Text(alertMessage)
                        .font(.title.bold())
                    Spacer()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

