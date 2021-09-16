//
//  ContentView.swift
//  WatchTabletTimer WatchKit Extension
//
//  Created by Daniel Pape on 11/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var active:Bool = false
    let defaults = UserDefaults.standard
    var body: some View {
//        List(){
        tabletCellView(active: active, initial: defaults.integer(forKey: "initial"),hours: defaults.integer(forKey: "hours"), minutes: defaults.integer(forKey: "minutes"))
        .navigationTitle(Text("Medori"))
        .onAppear(){
            requestPermission()
        }
    }
}

struct tabletCellView: View {
    
    @State var active: Bool
    @State var initial: Int
    @State var hours: Int
    @State var minutes: Int
    
    var initialValues: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
    var body: some View {
        VStack(spacing: 8.0){
            Spacer()
            HStack{
                Text("\(initialValues[initial])")
                    .font(.headline)
                    .frame(width: 40, height: 40)
                    .background(Color.black.opacity(0.2))
                    .foregroundColor(.black)
                    .clipShape(Circle())
                    .padding(.trailing)
//                    Spacer()
                VStack(alignment: .leading){
                    if(active){
                        Text("Do not take")
                        .foregroundColor(.black)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }else {
                        Text("Safe to take")
                        .foregroundColor(.black)
                    }
                    if(active){
                        HStack{
                            Text("Safe at 13:13")
                                .foregroundColor(.black)

                        }
                    }else {
                        HStack{
                            Image(systemName: "timer")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("\(hours > 0 ? "\(hours)hr\(hours == 1 ? "" : "s")" : "")\(hours > 0 && minutes >= 1 ? "," : "") \(minutes > 0 ? "\(minutes)m\(minutes == 1 ? "" : "s")" : "")")
                            .font(.headline)
                            .foregroundColor(.black)
                        }
                    }
                }
                Spacer()
            }.padding(.vertical,24.0)
            .padding(.horizontal, 8.0)
            .background(active ? Color.red : Color.green)
            .cornerRadius(32.0)
            
            Spacer()

            if (active){
                HStack{
                    Button(action: cancelTimer, label: {
                       HStack{
                           Spacer()
                           Text("Cancel")
                               .foregroundColor(.white)
                               .padding(.top, 4.0)
                               .padding(.bottom, 4.0)

                           Spacer()
                       }.padding()
                       .background(Color(.darkGray))
                       .clipShape(Capsule())
                       .frame(maxWidth: .infinity)
                   }).buttonStyle(PlainButtonStyle())
                }
            }else{
            
            HStack{
                NavigationLink(destination: NewDataView(initialSelection: initial, hoursSelection: hours, minuteSelection: minutes), label: {
                HStack{
                    Spacer()
                    Text("Edit")
                        .padding(.top, 4.0)
                        .padding(.bottom, 4.0)
                    Spacer()
                }.padding()
                .clipShape(Capsule())
            }).buttonStyle(PlainButtonStyle())
                Button(action: startTimer, label: {
                   HStack{
                       Spacer()
                       Text("Start")
                           .foregroundColor(.black)
                           .padding(.top, 4.0)
                           .padding(.bottom, 4.0)

                       Spacer()
                   }.padding()
                   .background(Color.green)
                   .clipShape(Capsule())
                   .frame(maxWidth: .infinity)
               }).buttonStyle(PlainButtonStyle())
            }
            }
            
        }.onAppear(){
            initial = UserDefaults.standard.integer(forKey: "initial")
            hours = UserDefaults.standard.integer(forKey: "hours")
            minutes = UserDefaults.standard.integer(forKey: "minutes")
        }
        
    }
    
    func cancelTimer() {
        cancelNotifications()
        active.toggle()
    }
    func startTimer() {
        print("timer started")
        scheduleNotification(minutes: 1)
        active.toggle()
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(active: false)
        ContentView(active: true)
    }
}
