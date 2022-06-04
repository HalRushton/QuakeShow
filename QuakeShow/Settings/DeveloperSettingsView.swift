//
//  SettingsView.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import SwiftUI

struct DeveloperSettingsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \QuakeItem.title, ascending: true)],
        animation: .default)
    private var quakes: FetchedResults<QuakeItem>
    
    var body: some View {
        clearAllDataView.padding()
        loadDataView.padding()
    }
    
    var loadDataView: some View {
        Button(action: {
            DataImporter.importData()
        }, label: {
            Text("Load initial data")
        })
    }
    
    var clearAllDataView: some View {
        Button(action: {
            quakes.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                print("error on deleting all \(error)")
            }
        }, label: {
            Text("Clear All Data")
        })
    }
}
