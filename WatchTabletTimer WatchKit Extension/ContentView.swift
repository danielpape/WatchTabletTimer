//
//  ContentView.swift
//  WatchTabletTimer WatchKit Extension
//
//  Created by Daniel Pape on 11/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(){
            VStack(spacing: 8.0){
                HStack{
                    Text("P")
                        .font(.headline)
                        .frame(width: 32, height: 32)
                        .background(Color.green)
                        .foregroundColor(.black)
                        .clipShape(Circle())
                        .padding(.trailing)
//                    Spacer()
                    VStack(alignment: .leading){
                        Text("Paracetamol")
                            .font(.title3)
                        Text("4 hours")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                Button(action: startTimer, label: {
                    HStack{
                        Spacer()
                        Text("Start Timer")
                        Spacer()
                    }.padding()
                    .background(Color(.darkGray))
                    .clipShape(Capsule())
                    .frame(maxWidth: .infinity)
                }).buttonStyle(PlainButtonStyle())
            }.padding(.vertical)
        }.navigationTitle(Text("Medori"))
    }
    
    func startTimer() {
        print("timer started")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
