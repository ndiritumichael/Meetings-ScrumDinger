//
//  DetailView.swift
//  Scrumdinger
//
//  Created by mac on 10/02/2022.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum:DailyScrum
    
    @State private var isPresentingEditView =  false
    @State private var data = DailyScrum.Data()
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView(scrum:$scrum)) {
                Label("Start Meeting",systemImage: "timer")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                }
                HStack{
                    Label("Length",systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) Minutes")
                }
                .accessibilityElement(children: .combine)
                
                HStack{
                    Label("Theme",systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                                                .foregroundColor(scrum.theme.accentColor)
                                                .background(scrum.theme.mainColor)
                                                .cornerRadius(4)
                } .accessibilityElement(children: .combine)
            }
            
            Section(header:Text("Attendees")){
                
                ForEach(scrum.attendees){person in
                    Label(person.name,systemImage: "person")
                    
                }
            }
            
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                                }
                
                ForEach(scrum.history){ history in
                    
                    HStack {
                                            Image(systemName: "calendar")
                                            Text(history.date, style: .date)
                                        }
                    
                    
                }
                                       
                       }
        }.navigationTitle(scrum.title)
        .sheet(isPresented: $isPresentingEditView, onDismiss:{ isPresentingEditView = false}){
                
                NavigationView{
                    DetailEditView(data:$data)
                        .navigationTitle(scrum.title)
                            .toolbar{
                                ToolbarItem(placement: .cancellationAction){
                                Button(action:{isPresentingEditView = false}){
                                    Text("Cancel")
                                }
                            }
                                
                                ToolbarItem(placement: .confirmationAction) {
                                                         Button("Done") {
                                                             scrum.update(from: data)
                                                             isPresentingEditView = false
                                                  
                                                         }
                                                     }

                            }
                }
            }
            .toolbar{
                
                Button(action:{
                    data = scrum.data
                    isPresentingEditView = true}){
                    Text("Edit")
                }
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            DetailView(scrum: .constant(DailyScrum.sampleData[1]))
    }
}
}
