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
    
    @State var initialSelection:Int
    @State var hoursSelection: Int
    @State var minuteSelection: Int
    
    var hoursValues: [Int] = Array(0...23)
    var minutesValues: [Int] = Array(0...59)
    var initialValues: [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    @State var editing:Bool = false
    
    
    var body: some View {
        Form {
            Section(header: Text("Details")) {
                HStack{
                    Picker(selection: $initialSelection, label: Text("Initial"), content: {
                        ForEach(0..<25){initial in
                            Text("\(initialValues[initial])").tag(initial)
                        }
                    }).pickerStyle(WheelPickerStyle())
                    Picker(selection: $hoursSelection, label: Text("Hours"), content: {
                        ForEach(0..<23){hour in
                            Text("\(hour)").tag(hour)
                        }
                    }).pickerStyle(WheelPickerStyle())
                    Picker(selection: $minuteSelection, label: Text("Minutes"), content: {
                        ForEach(0..<60){min in
                            Text("\(min)").tag(min)
                        }
                    }).pickerStyle(WheelPickerStyle())
                }
            }
            Section{
                
                Button(action: {
                    UserDefaults.standard.set(initialSelection, forKey: "initial")
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
        NewDataView(initialSelection: 0, hoursSelection: 4, minuteSelection: 0)
    }
}

