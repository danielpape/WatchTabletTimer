//
//  NewDataView.swift
//  TaskApp
//
//  Created by Daniel Pape on 07/10/2020.
//

import SwiftUI
import Foundation

struct NewDataView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let defaults = UserDefaults.standard
    
    @State var initialSelection:String
    @State var hoursSelection: Int
    @State var minuteSelection: Int
    
    var hoursValues: [Int] = Array(0...23)
    var minutesValues: [Int] = Array(0...59)
    var initialValues: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @State var editing:Bool = false
    
    var body: some View {
        VStack{
            TabView {
            VStack{
                Text("Time")
                    Button("\(hoursSelection > 0 ? "\(hoursSelection) hour\(hoursSelection == 1 ? "" : "s")" : "")\(hoursSelection > 0 && minuteSelection >= 1 ? " ," : "") \(minuteSelection > 0 ? "\(minuteSelection) minute\(minuteSelection == 1 ? "" : "s") " : "")"){
                        print("Set time")
                    }
                    
//                    Picker(selection: $hoursSelection, label: Text("Hours"), content: {
//                        ForEach(0..<24){hour in
//                            Text("\(hour)").tag(hour)
//                        }
//                    }).pickerStyle(InlinePickerStyle())
//                    Picker(selection: $minuteSelection, label: Text("Minutes"), content: {
//                        ForEach(0..<60){min in
//                            Text("\(String(format: "%02d", min))").tag(min)
//                        }
//                    }).pickerStyle(InlinePickerStyle())
//                    Picker(selection: $initialSelection, label: Text("Initial"), content: {
//                        ForEach(0..<25){initial in
//                            Text("\(initialValues[initial])").tag(initial)
//                        }
//                    })
                
            }
                VStack{
                    Text("Initial")
                TextField("Initial", text: $initialSelection)
            }.tabViewStyle(.page)
            }
            Button(action: {
                    UserDefaults.standard.set(initialSelection, forKey: "initial")
                    UserDefaults.standard.set(hoursSelection, forKey: "hours")
                    UserDefaults.standard.set(minuteSelection, forKey: "minutes")
                    presentationMode.wrappedValue.dismiss()
                    
                    
                }) {
                    Text("Save Medication")
                            .foregroundColor(.white)
                            .padding(.bottom, 4.0)
                }.padding()
                .buttonStyle(PlainButtonStyle())
                .clipShape(Capsule())
        }.onAppear(){
            defaults.setValue(true, forKey: "onboardingSeen")
        }.navigationTitle(Text("Edit"))
    }
}

struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        NewDataView(initialSelection: "B", hoursSelection: 4, minuteSelection: 0)
    }
}

