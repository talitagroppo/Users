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
    var age: Int
    var friends: [Friend]
    
    static var example: User = User(id: UUID(), name: "Talita", age: 27, friends: [Friend.example])
}
struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
    
    static var example: Friend = Friend(id: UUID(), name: "Tiago")
}

//struct Response: Codable {
//    var user : [User]
//    var friend: [Friend]
//}
//
//struct User: Codable {
//    var id: String
//    var name: String
//    var company: String
//}
//struct  Friend: Codable{
//    var age: String
//    var about: String
//}

struct ContentView: View {
    @State private var user = [User]()
    @State private var friend = [Friend]()
    
    var body: some View {
        NavigationView{
            List(user) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
//                    Text(item.name)
                }
            }
            .onAppear(perform: loadData)
        }
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
                    self.user = [User.example]
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
