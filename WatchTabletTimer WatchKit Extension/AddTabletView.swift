//
//  NewDataView.swift
//  TaskApp
//
//  Created by Daniel Pape on 07/10/2020.
//

import SwiftUI

struct NewDataView: View {
    
    private var hoursValues: [Int] = Array(0...23)
    private var minutesValues: [Int] = Array(0...59)
    @State private var hoursSelection: Int = 8
    @State private var minuteSelection: Int = 0
    @State private var editing:Bool = false
    
    @State private var name = ""
    
    var body: some View {
            Form {
                Section(header: Text("Medication Name")) {
                    TextField("Name", text: $name)
                }
                
                Section {
                    
                        Button(action: {
                          
                        }) {
                            Text("Save Medication")
                                .foregroundColor(Color.blue)
                        }
                }
            }
        }
        
    
}

