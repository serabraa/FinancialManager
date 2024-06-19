//
//  ContentView.swift
//  FinancialManager
//
//  Created by Sergey on 24.05.24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate: Date = Date()
    @State private var balance: Double = 0.0;
    @State private var showingInputSheet = false
    @State private var inputAmount: String = ""
    @State private var transactions: [Transaction] = []  // Array to hold transactions


    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    previousDay()
                }) {
                    Image(systemName: "chevron.left")
                        .padding()
                }
                
                Spacer()
                
                Text(currentDate.formatted(date: .complete, time: .omitted))
                    .font(.title)
                    .foregroundColor(Color.blue)
                    .multilineTextAlignment(.center)
                    .padding(0.0)

                
                Spacer()
                
                Button(action: {
                    nextDay()
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
                
                
                
            }
            Text("Balance: \(balance, specifier: "%.2f")")
                .font(.title)
                .padding()
            Spacer()
            
            
            // Displaying transactions for the current day with time only
            List(transactions.filter { Calendar.current.isDate($0.time, inSameDayAs: currentDate) }) { transaction in
                Text("\(transaction.time.formatted(date: .omitted, time: .shortened)) - \(transaction.amount > 0 ? "+" : "")\(transaction.amount, specifier: "%.2f")")
            }
            
            
            Button(action: {toggleInputSheet()
                // Action to perform when button is tapped
            }) {
                Image(systemName: "plus.circle.fill") // Using SF Symbols for the plus icon
                    .resizable() // Make the image resizable
                    .frame(width: 50, height: 50) // Set the frame size of the image
                    .foregroundColor(.green) // Set the color of the icon
            }
            .padding() // Add padding around the button for tap-ability
            .sheet(isPresented: $showingInputSheet){
                VStack{
                    TextField("Enter amount", text: $inputAmount)
                                            .keyboardType(.decimalPad)
                                            .padding()

                                        Button("Add to Balance") {
                                            addingToBalance()
                                            self.showingInputSheet = false // Dismiss the sheet after adding
                                        }
                                        .padding()
                }
            }
            
        }
    }
    
    // Function to show the input modal
    func showInputModal() {
        self.showingInputSheet = true
    }
    func nextDay() {
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }
    
    func previousDay() {
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
    }
    // Function to add the entered amount to the balance
    func addingToBalance(){
        if let amount = Double(inputAmount) {
                    balance += amount
            let newTransaction = Transaction(amount: amount, time: Date())
            transactions.append(newTransaction)  // Record the transaction
                    inputAmount = ""  // Reset the input field after adding
                }
    }
    func toggleInputSheet(){
        if(showingInputSheet==false){
            showingInputSheet=true;
        }else {showingInputSheet=false}
    }
}

struct Transaction: Identifiable {
    let id = UUID()
    let amount: Double
    let time: Date
}


#Preview {
    ContentView()
}

