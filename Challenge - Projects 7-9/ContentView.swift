//
//  ContentView.swift
//  Challenge - Projects 7-9
//
//  Created by Talita Groppo on 24/02/2021.
//

import SwiftUI

struct User: Codable, Identifiable {
    struct Friend: Codable {
        let id: UUID
        let name: String
       static var example: Friend = Friend(id: UUID(), name: "Tiago")
    }

    let id: UUID
    let name: String
    let age: Int
    let friends: Friend
    
  static var example: User = User(id: UUID(), name: "Talita", age: 27, friends: Friend.example)
}

struct ContentView: View {
    @State private var user = [User]()
    
    var body: some View {
        NavigationView{
            List(user) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                    .font(.title)
                Text("Friends - Name: \(item.friends.name)")
                    Text("ID: \(item.friends.id)")
                }
//                Spacer()
//                Button("Information") {
//                    let encoder = JSONEncoder()
//
//                    if let data = try? JSONEncoder().encode(self.user) {
//                        UserDefaults.standard.set(data, forKey: "https://www.hackingwithswift.com/samples/friendface.json")
//                        print ("\(item.friends)")
//                    }else{
//                        print("Error")
//                    }
                }
            .padding(.horizontal)
//       .buttonStyle(PlainButtonStyle())
        .navigationBarTitle("Challenge")
    
//   Spacer(minLength: 25)
    .onAppear(perform: loadData)
        }
}
    func loadData(){
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")else{
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
//                        self.loadData()
                        return
                    }
                } catch {
                    print("decodeError")
                   self.user = [User.example]
                    return
                }
                
//                if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
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



