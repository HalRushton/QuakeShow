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
        loadSmallDataView.padding()
        loadMedDataView.padding()
        loadLargeDataView.padding()
    }
    
    var loadSmallDataView: some View {
        Button(action: {
            DataImporter.importData("quakedata")
        }, label: {
            Text("Load small data set")
        })
    }
    
    var loadMedDataView: some View {
        Button(action: {
            DataImporter.importData("medata")
        }, label: {
            Text("Load medium data set")
        })
    }
    
    var loadLargeDataView: some View {
        Button(action: {
            DataImporter.importData("odata")
        }, label: {
            Text("Load 30 day set")
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
