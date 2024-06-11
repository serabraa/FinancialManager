//
//  ContentView.swift
//  FinancialManager
//
//  Created by Sergey on 24.05.24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate: Date = Date()

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
                    .padding()
//                    .gesture(
//                                            DragGesture(minimumDistance: 20)
//                                                .onEnded { swipe in
//                                                    if swipe.translation.width > 0 {
//                                                        previousDay()
//                                                    } else if swipe.translation.width < 0 {
//                                                        nextDay()
//                                                    }
//                                                }
//                                        )

                Spacer()
                
                Button(action: {
                    nextDay()
                }) {
                    Image(systemName: "chevron.right")
                        .padding()
                }
            }
        }
    }
    
    func nextDay() {
        currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
    }

    func previousDay() {
        currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
    }
}

#Preview {
    ContentView()
}

