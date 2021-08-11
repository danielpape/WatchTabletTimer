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
                    Spacer()
                    VStack(alignment: .leading){
                        Text("Paracetamol")
                            .font(.title3)
                        Text("4 hours")
                            .font(.subheadline)
                    }
                }
                Button("Start Timer"){
                    
                }.padding()
                .background(Color(.darkGray))
                .clipShape(Capsule())
            
            }.padding(.vertical)
            HStack{
                Text("C")
                    .font(.headline)
                    .frame(width: 40, height: 40)
                    .background(Color.red)
                    .foregroundColor(.black)
                    .clipShape(Circle())
                Spacer()
                Text("24 hours")
            }
        }.navigationTitle(Text("Medori"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
