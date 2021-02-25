//
//  ContentView.swift
//  Challenge - Projects 7-9
//
//  Created by Talita Groppo on 24/02/2021.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id: UUID
    let name: String
    let age: Int
    let friends: [Friend]
    
//    static var example: User = User(id: UUID(), name: "Talita", age: 27, friends: [Friend.example])
}
struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
    
//    static var example: Friend = Friend(id: UUID(), name: "Tiago")
}

struct ContentView: View {
    @ObservedObject var user = User()
        @ObservedObject var friend = Friend()
        @State private var showingNames = true
    
    
    var body: some View {
        NavigationView{
            List(user) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(self.friend.description)
                        .padding()
                    
                    Text(self.user.description)
                        .padding()
                    
                    Button(action: {
                                       self.showingNames.toggle()
                                   }, label: {
                                    Text(self.friend.description)
                                   })
                }

                Spacer()
//            .padding(.horizontal)
        .buttonStyle(PlainButtonStyle())
    
    Spacer(minLength: 25)
}
}
.onAppear(perform: loadData)
.navigationTitle("Challenge")
}
    func loadData(){
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else{
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode([User].self, from: data)
                    print(decodedResponse)
                    DispatchQueue.main.async {
                        self.user = decodedResponse
                    }
                } catch {
                    print("decodeError")
//                    self.user = [User.example]
                    return
                }
//                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//
//                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



