//
//  ContentView.swift
//  List&Row
//
//  Created by Akhmad Talatov on 18/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
            NavigationLink(destination: SecondView()) {
                Text("1st task")
            }
            NavigationLink(destination: ButtonPlay()) {
                Text("2st task")
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
