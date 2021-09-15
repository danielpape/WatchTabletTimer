//
//  NewDataView.swift
//  TaskApp
//
//  Created by Daniel Pape on 07/10/2020.
//

import SwiftUI

struct NewDataView: View {
    
    @Environment(\.presentationMode) var presentationMode

    let defaults = UserDefaults.standard
    
    @State var initial:String
    @State var hoursSelection: Int
    @State var minuteSelection: Int
    
    var hoursValues: [Int] = Array(0...23)
    var minutesValues: [Int] = Array(0...59)
    @State var editing:Bool = false
    
    
    var body: some View {
            Form {
                Section(header: Text("Medication Initial")) {
                    TextField("Initial", text: $initial)
                }
                Section(header: Text("Time between doses")){
                    HStack{
                        Picker(selection: $hoursSelection, label: Text("Hours"), content: {
                            ForEach(0..<23){hour in
                                Text("\(hour)").tag(hour)
                            }
                        })
                        Text(":")
                        Picker(selection: $minuteSelection, label: Text("Minutes"), content: {
                            ForEach(0..<60){min in
                                Text("\(min)").tag(min)
                            }
                        })
                    }
                }
                
                Section {
                    
                        Button(action: {
                            UserDefaults.standard.set(initial, forKey: "initial")
                            UserDefaults.standard.set(hoursSelection, forKey: "hours")
                            UserDefaults.standard.set(minuteSelection, forKey: "minutes")
                            presentationMode.wrappedValue.dismiss()

                            
                        }) {
                            Text("Save Medication")
                                .foregroundColor(Color.blue)
                        }
                }
            }
        }
        
    
}

struct NewDataView_Previews: PreviewProvider {
    static var previews: some View {
        NewDataView(initial: "P", hoursSelection: 4, minuteSelection: 0)
    }
}

