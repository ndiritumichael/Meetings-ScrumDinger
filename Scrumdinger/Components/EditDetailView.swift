//
// Created by mac on 11/02/2022.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data : DailyScrum.Data
    @State private var newAttendeeName = ""

    var body: some View {
       Form{
           Section(header:Text("Meeting Info")
           ){
               TextField("Title",text:$data.title)
               HStack{
                   Slider(value: $data.lengthInMinutes,in: 5...30,step: 1){
                       Text("Length")
                   }.accessibilityValue("\(Int(data.lengthInMinutes)) minutes")
                  
                   Spacer()
                   Text("\(Int(data.lengthInMinutes)) Minutes")
                       .accessibilityHidden(true)
                  
                   
               }
               ThemePicker(selection: $data.theme)
           }
           
           Section(header:Text("Attendees")){
               
               ForEach(data.attendees){person in
                   Text(person.name)
                   
               }
               .onDelete{ indices in
                   data.attendees.remove(atOffsets : indices)
                   
               }
               HStack{
                   TextField("New Attendee",text :$newAttendeeName)
                   Button(action : {
                       withAnimation{
                           let attendee = DailyScrum.Attendee(name: newAttendeeName)
                           
                           data.attendees.append(attendee)
                           newAttendeeName = ""
                           
                       }
                   }){
                       Image(systemName: "plus.circle.fill")
                   }.disabled(newAttendeeName.isEmpty)
               }
           }

       }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
