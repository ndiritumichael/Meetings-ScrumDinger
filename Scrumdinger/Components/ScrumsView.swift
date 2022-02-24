//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by mac on 10/02/2022.
//

import SwiftUI

struct ScrumsView: View {
 @Binding var scrums: [DailyScrum]
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresentingNewScrumView = false
    @State private var newScrum = DailyScrum.Data()
    
    let saveAction : () -> Void
    
    var body: some View {
        List{
            ForEach($scrums){ $scrum  in
                
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                                 CardView(scrum: scrum)
                             }
                             .listRowBackground(scrum.theme.mainColor)
                  
                
            }
            
            
        }
        .sheet(isPresented:$isPresentingNewScrumView){
            NavigationView{
                DetailEditView(data: $newScrum)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            
                            Button("Cancel"){
                                
                                isPresentingNewScrumView = false
                                newScrum = DailyScrum.Data()
                                
                            }
                           
                            
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Add"){
                                let newerScrum = DailyScrum(data: newScrum)
                                scrums.append(newerScrum)
                                
                                isPresentingNewScrumView = false
                                newScrum = DailyScrum.Data()
                            }
                           
                            
                        }
                    }
            }
        }
        .navigationTitle("Daily Scrums")
        .toolbar{
            Button(action:{
                isPresentingNewScrumView = true
            }){
                Image(systemName: "plus")
            }  .accessibilityLabel("New Scrum")       }
        .onChange(of: scenePhase) { phase in
            
            if phase == .inactive{saveAction()}
                }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ScrumsView(scrums: .constant(DailyScrum.sampleData)){
                
            }
        }
    }
}
