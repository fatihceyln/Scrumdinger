//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 2.05.2022.
//

import SwiftUI

struct DetailEditView: View {
    
    @Binding var data: DailyScrum.Data
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form {
            // Meeting Info section
            Section {
                TextField("Title", text: $data.title)
                
                HStack {
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1)
                    
                    Spacer()
                    
                    Text("\(Int(data.lengthInMinutes)) minutes")
                }
                
                ThemePickerView(selection: $data.theme)
                
            } header: {
                Text("Meeting Info")
            }

            // Attendees section
            Section {
                
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    
                    Button {
                        withAnimation(.default) {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            data.attendees.append(attendee)
                            newAttendeeName = ""
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
                
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
            } header: {
                Text("Attendees")
            }

        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(DailyScrum.sampleData[0].data))
    }
}
