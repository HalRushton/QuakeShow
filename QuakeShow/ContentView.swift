//
//  ContentView.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    QuakeListView(viewModel: QuakeListViewModel(quakePublisher: QuakeProvider.shared.quakes.eraseToAnyPublisher()))
                }, label: {
                    Text("Big Quakes")
                })
                Text("option 2")
                Text("option 3")
            }
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: {
                        DeveloperSettingsView()
                    }, label: {
                        Image(systemName: "gear")
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
