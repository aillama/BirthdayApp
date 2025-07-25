//
//  ContentView.swift
//  BirthdayApp
//
//  Created by Ananya Gogula on 7/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var friends: [Friend]
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack{
            List(friends){friend in
                HStack{
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month(.wide).day().year())
        }
        
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom){
                VStack (alignment: .center, spacing: 20){
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in:Date.distantPast...Date.now, displayedComponents: .date){
                        //dollar sign binds it to the @State variable above
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    Button("Save"){
                        //new object in the class for the array
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        //now it saves temporarily into the model context? but we still need the array because that is where we are pulling from?
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    .bold()
                }
                .padding()
                .background(.bar)
            }
        }
    
        
        }
    }


#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)

}
