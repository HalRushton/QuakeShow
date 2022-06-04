//
//  DataImporter.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import Foundation
import CoreData

struct DataImporter {
    static func importData() {
        guard let path = Bundle.main.path(forResource: "quakedata", ofType: "json") else {
            assert(true, "No initial data")
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let featureCollection = try JSONDecoder().decode(FeatureCollection.self, from: data)
            let context = PersistenceController.shared.container.viewContext
            featureCollection.features.forEach { feature in
                let newQuake = QuakeItem(context: context)
                newQuake.title = feature.properties.title
                newQuake.tz = feature.properties.tz ?? 0
                newQuake.time = feature.properties.time ?? 0
                newQuake.place = feature.properties.place
                newQuake.magnitude = feature.properties.mag ?? 0
                newQuake.features = feature.properties.saveItem(context: context)
                newQuake.coordinates = feature.geometry.coordinates.saveItem(context: context)
            }
            try context.save()
            UserDefaults.standard.set(true, forKey: UserKey.Bool.hasSetupDatabase.rawValue)
        } catch {
            assert(true, "failed to decode initial data")
        }
    }
}
