//
//  ContentView.swift
//  WatchTabletTimer WatchKit Extension
//
//  Created by Daniel Pape on 11/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var active:Bool = false
    @State var showingAddView = false
    let defaults = UserDefaults.standard
    var body: some View {
//        List(){
        tabletCellView(active: active, cancelled: defaults.bool(forKey: "cancelled"), initial: defaults.string(forKey: "initial") ?? "",hours: defaults.integer(forKey: "hours"), minutes: defaults.integer(forKey: "minutes"))
        .navigationTitle(Text("Medori"))
        .onAppear(){
            requestPermission()
            if(defaults.bool(forKey: "onboardingSeen") == false){
                showingAddView = true
            }
        }.sheet(isPresented: $showingAddView, content: {
            NewDataView(initialSelection: "B", hoursSelection: 4, minuteSelection: 0)
        })
    }
}

struct tabletCellView: View {
    
    @State var active: Bool
    @State var cancelled: Bool
    @State var initial: String
    @State var hours: Int
    @State var minutes: Int
    
    var initialValues: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        
    var body: some View {
        VStack(spacing: 8.0){
            Spacer()
            HStack{
                Text("\(initial)")
                    .font(.headline)
                    .frame(width: 32, height: 32)
                    .background(Color.black.opacity(0.2))
                    .foregroundColor(.black)
                    .clipShape(Circle())
                    .padding(.trailing, 4.0)
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
                            Text("Safe at \(safeToTake(int: hours*60 + minutes))")
                                .foregroundColor(.black)

                        }
                    }else {
                        HStack{
                            Image(systemName: "timer")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text("\(hours)h \(minutes > 0 ? "\(minutes) m" : "")")
//                            Text("\(hours > 0 ? "\(hours)hr\(hours == 1 ? "" : "s")" : "")\(hours > 0 && minutes >= 1 ? "," : "") \(minutes > 0 ? "\(minutes)m\(minutes == 1 ? "" : "s")" : "")")
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
            initial = UserDefaults.standard.string(forKey: "initial") ?? ""
            hours = UserDefaults.standard.integer(forKey: "hours")
            minutes = UserDefaults.standard.integer(forKey: "minutes")
            cancelled = UserDefaults.standard.bool(forKey: "cancelled")
            checkIfTimerIsActive()
        }
        
    }
    
    func cancelTimer() {
        cancelNotifications()
        UserDefaults.standard.setValue(true, forKey: "cancelled")
        active.toggle()
    }
    func startTimer() {
        print("timer started")
        scheduleNotification(minutes: TimeInterval((hours*60)+minutes))
        UserDefaults.standard.set(Date().timeIntervalSince1970, forKey: "lastTriggered")
        UserDefaults.standard.setValue(false, forKey: "cancelled")
        active.toggle()
    }
    
    func safeToTake(int:Int) -> String {
        let lastTriggered = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "lastTriggered"))
        let safeToTakeTime = lastTriggered.addingTimeInterval(TimeInterval(hours*60*60)+TimeInterval(minutes*60)) 
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: safeToTakeTime)
    }
    
    func checkIfTimerIsActive() {
        
        let timeStamp = Date(timeIntervalSince1970: UserDefaults.standard.double(forKey: "lastTriggered"))
        
        if(UserDefaults.standard.bool(forKey: "cancelled") == true){
            active = false
        }
        
        let totalMinutes = Double(((hours*60) + minutes) * 60)
        let remainingMinutes = (totalMinutes) - Date().timeIntervalSince(timeStamp)
        let minutesSinceLastTriggered = Date().timeIntervalSince(timeStamp)
        if (remainingMinutes > minutesSinceLastTriggered && cancelled == false){
            active = true
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(active: false)
        ContentView(active: true)
    }
}
