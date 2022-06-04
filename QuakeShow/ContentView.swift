//
//  ContentView.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText: String = ""
    @State var sortType: SortViewType = .magnitude
    @State var sortAscending: Bool = false
    
    @FetchRequest(
        sortDescriptors
        : [NSSortDescriptor(keyPath: \QuakeItem.title, ascending: true)],
        animation: .default)
    
    private var quakes: FetchedResults<QuakeItem>
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
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: {
                        DeveloperSettingsView()
                    }, label: {
                        Image(systemName: "gear")
                    })
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortView(sortViewModel: SortViewModel(sortViewType: $sortType, sortAscending: $sortAscending))
//                    NavigationLink(destination: {
//                        Text("sort me")
//                    }, label: {
//                        Image(systemName: "arrow.up.arrow.down")
//                    })
                }
            }

            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { quakes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                print("error \(error) in saving context while deleting")
                assert(true, "could not save the context while deleting")
            }
        }
    }
     
    var searchResults: [QuakeItem] {
        if searchText.isEmpty {
            return quakes.map { $0 }
        } else {
            return quakes.filter { $0.title?.contains(searchText) == true }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
