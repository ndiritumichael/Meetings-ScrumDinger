/*
See LICENSE folder for this sample’s licensing information.
*/

import SwiftUI
import AVFoundation
struct MeetingView: View {
    @Binding  var scrum: DailyScrum
    @StateObject var scrumTimer:ScrumTimer = ScrumTimer()
    private var player:AVPlayer{
        AVPlayer.sharedDingPlayer
    }
    var body: some View {
       
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
        VStack {
            MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
           
            Circle()
                .strokeBorder(lineWidth: 24,antialiased: true)
            MeetingFooterView(speakers: scrumTimer.speakers, skipAction: {scrumTimer.skipSpeaker()})
        }.padding()
        .foregroundColor(.accentColor)
        .onAppear{
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear{
            scrumTimer.stopScrum()
            
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrum.timer.secondsElapsed / 60)
                        scrum.history.insert(newHistory, at: 0)
        }
            
            }.navigationBarTitleDisplayMode(.inline)
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
