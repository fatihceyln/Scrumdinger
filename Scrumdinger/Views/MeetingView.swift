//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Fatih Kilit on 1.05.2022.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer: ScrumTimer = ScrumTimer()
    
    private var player: AVPlayer {
        AVPlayer.sharedDingPlayer
    }
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24) // -> Inner stroke
                    //.stroke(lineWidth: 24) // -> Outter stroke
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear(perform: {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        })
        .onDisappear(perform: {
            scrumTimer.stopScrum()
        })
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
