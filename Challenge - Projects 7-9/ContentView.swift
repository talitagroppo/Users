//
//  ContentView.swift
//  Challenge - Projects 7-9
//
//  Created by Talita Groppo on 24/02/2021.
//

import SwiftUI
struct User: Codable {
    var friends: [Friend]
}

struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}
struct ContentView: View {
    @State private var friends = [Friend]()

    var body: some View {
        List(friends) { item in
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("\(item.id)")
            }
        }
        .onAppear(perform: loadData)
        .navigationBarTitle("Challenge", displayMode: .inline)
    }
func loadData() {
    guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
        print("Invalid URL")
        return
    }
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, user, error in
        if let data = data {
            if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
                
                DispatchQueue.main.async {

                    self.friends = decodedResponse.friends
                }

                
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



//
//struct User: Codable, Identifiable {
//    let id: UUID
//    let name: String
//    let age: Int
//    let friends: Friend
//
//  static var example: User = User(id: UUID(), name: "Talita", age: 27, friends: Friend.example)
//}
//struct Friend: Codable, Identifiable {
//    let id: UUID
//    let name: String
//   static var example: Friend = Friend(id: UUID(), name: "Tiago")
//}
//struct ContentView: View {
//
//func loadData(){
//    let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
//var request = URLRequest(url: url)
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//request.httpMethod = "POST"
//request.httpBody = Fr
//
//    URLSession.shared.dataTask(with: request) { data, user, error in
//        guard let data = data else{
//            print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
//            return
//        }
//    guard let  encodedFriend = try? JSONEncoder().encode(friends)else{
//        print("Failed")
//        return
//    }
//
//
////
////            if let decodedUser = try? JSONDecoder().decode(User.self, from: data) {
////                return
////
////            } else{
////                print("Invalid response from server")
////                return
////            }
////
//    }.resume()
//}
//
//    @State private var friends = [Friend]()
//    @State private var user = [User]()
//
//    var body: some View {
//        NavigationView{
//            List(friends) { item in
//                VStack(alignment: .leading) {
//                    Text(item.name)
//                    .font(.title)
//                Text("Friends - Name: \(item.name)")
//                    Text("ID: \(item.id)")
//                    Button("Information"){
//                        print("\(item.id) \(item.name)")
//                    }
//                    .padding()
//                }
////                Spacer()
////                Button("Information") {
////                    let encoder = JSONEncoder()
////
////                    if let data = try? JSONEncoder().encode(self.user) {
////                        UserDefaults.standard.set(data, forKey: "https://www.hackingwithswift.com/samples/friendface.json")
////                        print ("\(item.friends)")
////                    }else{
////                        print("Error")
//                    }
//            .padding(.horizontal)
////       .buttonStyle(PlainButtonStyle())
//        .navigationBarTitle("Challenge", displayMode: .inline)
//        }
////   Spacer(minLength: 25)
//    .onAppear(perform: loadData)
//        }
//                   }
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
//
