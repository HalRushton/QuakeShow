//
//  QuakeShowApp.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import SwiftUI

@main
struct QuakeShowApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
