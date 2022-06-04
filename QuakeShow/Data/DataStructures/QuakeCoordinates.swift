//
//  QuakeCoordinates.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/1/22.
//

import Foundation
import CoreData

struct QuakeCoordinates: Decodable {
    let longitude: Double
    let latitude: Double
    let depth: Double
    
    func saveItem(context: NSManagedObjectContext) -> QuakeCoordinatesItem {
        let item = QuakeCoordinatesItem(context: context)
        item.latitude = latitude
        item.longitude = longitude
        item.depth = depth
        return item
    }
}
