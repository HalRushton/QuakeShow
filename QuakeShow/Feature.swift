//
//  Feature.swift
//  Quake
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import Foundation
import Metal
import CoreLocation
import CoreData

struct FeatureCollection: Decodable {
    let metadata: CollectionMetadata
    let bbox: [Double]//BoundingBox
    let features: [Feature]
}

struct CollectionMetadata: Decodable {
    let generated: Int64
    let url: String
    let title: String
    let api: String
    let count: Int
    let status: Int
}

struct BoundingBox: Decodable {
    let coordinates: [Double]
    // TODO decode these
//    let minimum: QuakeCoordinates
//    let maximum: QuakeCoordinates
}

struct Feature: Decodable {
    let properties: FeatureProperties
    let geometry: FeatureGeometry
    let id: String
}

struct Quake {
    let magnitude: Double
    let place: String
    let time: Int64
    let tz: Int16
    let detail: String
    let coordinates: QuakeCoordinates
    let properties: FeatureProperties
}

struct FeatureProperties: Decodable {
    let mag: Double?
    let place: String?
    let time: Int64?
    let updated: Int64
    let tz: Int16?
    let url: String?
    let detail: String?
    let felt: Int16?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String?
    let tsunami: Int16?
    let sig: Int16?
    let net: String?
    let code: String?
    let ids: String?
    let sources: String?
    let types: String?
    let nst: Int16?
    let dmin: Double?
    let rms: Double?
    let gap: Double?
    let magType: String?
    let title: String?
    
    func saveItem(context: NSManagedObjectContext) -> FeaturePropertiesItem {
        let item = FeaturePropertiesItem(context: context)
        item.alert = alert
        item.cdi = cdi ?? 0
        item.code = code
        item.detail = detail
        item.dmin = dmin ?? 0
        item.felt = felt ?? 0
        item.gap = gap ?? 0
        item.ids = ids
        item.mag = mag ?? 0
        item.magType = magType
        item.mmi = mmi ?? 0
        item.net = net
        item.nst = nst ?? 0
        item.place = place
        item.rms = rms ?? 0
        item.sig = sig ?? 0
        item.sources = sources
        item.status = status
        item.time = time ?? 0
        item.tsunami = tsunami ?? 0
        item.types = types
        item.tz = tz ?? 0
        item.updatedTime = updated
        item.url = url
        return item
    }
}

struct FeatureGeometry: Decodable {
    let type: String
    let coordinates: QuakeCoordinates
    
    enum CodingKeys: String, CodingKey {
        case type
        case coordinates
    }
        
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type) ?? "unknown"
        let array = try values.decode([Double].self, forKey: .coordinates)
        coordinates = QuakeCoordinates(longitude: array[0], latitude: array[1], depth: array[2])
      }
}

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

