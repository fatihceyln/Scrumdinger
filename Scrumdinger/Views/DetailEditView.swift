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
                    Slider(value: $data.lengthInMinutes, in: 5...30, step: 1) {
                        Text("Length")
                        // The Text view won't appear on screen, but VoiceOver uses it to identify the purpose of the slider
                    }
                    .accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                    
                    Spacer()
                    
                    Text("\(Int(data.lengthInMinutes)) minutes")
                        .accessibilityHidden(true)
                }
                
                ThemePickerView(selection: $data.theme)
            } header: {
                Text("Meeting Info")
            }

            // Attendees section
            Section {
                ForEach(data.attendees) { attendee in
                    Text(attendee.name)
                }
                .onDelete { indices in
                    data.attendees.remove(atOffsets: indices)
                }
                
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
                            .accessibilityLabel("Add attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
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
