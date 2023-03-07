import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount: Double?
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let currency = 0
    
    let tipPercentages = Array(stride(from: 0 , through: 100, by: 5))
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = (checkAmount ?? 0.0) / 100 * tipSelection
        let grandTotal = (checkAmount ?? 0.0) + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalWithTip: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = (checkAmount ?? 0.0) / 100 * tipSelection
        let grandTotal = (checkAmount ?? 0.0) + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people:", selection: $numberOfPeople) {
                        ForEach(2 ..< 100 ) { num in
                            Text("\(num) people")
                        }
                    }
                } header: {
                    Text("Bill Details")
                }
                
                Section {
                    Picker("Tip Percentage:", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { tip in
                            Text(tip, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                } header: {
                    Text("Amount Per Person")
                }
                
                Section {
                    Text(totalWithTip, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Grand Total With Tip")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
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
