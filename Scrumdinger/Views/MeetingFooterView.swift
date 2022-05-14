//
//  MeetingFooter.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 5.05.2022.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> ()
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy({ $0.isCompleted })
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else {
            return "No more speakers"
        }
        return "Speakers \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button {
                        skipAction()
                    } label: {
                        Image(systemName: "forward.fill")
                    }
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooter_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
