//
//  ContentView.swift
//  Challenge - Projects 7-9
//
//  Created by Talita Groppo on 24/02/2021.
//

import SwiftUI
struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var friends: [Friend]
    
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
    static var example: Friend = Friend(id: UUID(), name: "Tiago")
}
struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination:
                                List {
                                    ForEach(user.friends) {friend in
                                        Text(friend.name)
                                    }
                                }
                ) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                    }
                }
                
            }
            .onAppear(perform: loadData)
            .navigationBarTitle("Challenge", displayMode: .inline)
        }
    }
    func loadData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, user, error in
            if let data = data {
//                let serialized = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                print(serialized)
                if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.users = decodedResponse
                        return
                    }
                }else{
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            return
        }.resume()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
