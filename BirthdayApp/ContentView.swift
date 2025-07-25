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
    //allows us to read default values in the SwiftUI file
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    
    var body: some View {
        NavigationStack{
            List{
                //ForEach inside a list tells SwiftUI to treat each row uniquely (makes it easier to manage deletions or other row-level operations)
                ForEach(friends) { friend in
                    HStack{
                        HStack{
                            Text(friend.name)
                            Spacer()
                            Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                        }
                    }
        }
                .onDelete(perform: deleteFriend)
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
    //what does this do? what are offsets and index and indexset
    func deleteFriend(at offsets: IndexSet){
        for index in offsets {
            let friendtoDelete = friends[index]
            context.delete(friendtoDelete)
        }
    }
    }


#Preview {
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)

}
