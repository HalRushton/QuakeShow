//
//  Feature.swift
//  Quake
//
//  Created by Hal Jay Rushton on 5/30/22.
//

import Foundation
import Metal
import CoreLocation

struct FeatureCollection: Codable {
    let type: CollectionType
    let metadata: CollectionMetadata
    let bbox: BoundingBox
    let features: [Feature]
}

enum CollectionType: String, Codable {
    case featureCollection = "FeatureCollection"
    case unknown
}

struct CollectionMetadata: Codable {
    let generated: Int64
    let url: String
    let title: String
    let api: String
    let count: Int
    let status: Int
}

struct BoundingBox: Codable {
    let minimum: QuakeCoordinates
    let maximum: QuakeCoordinates
}

enum FeatureType: String, Codable {
    case feature = "Feature"
    case unknown
}

enum EventType: String, Codable {
    case earthquake
    case unknown
}

struct Feature: Codable {
    let featureType: FeatureType
    let properties: FeatureProperties
    let geometry: FeatureGeometry
    let id: String
}

struct Quake {
    let magnitude: Double
    let place: String
    let time: Int64
    let tz: Int
    let detail: String
    let coordinates: QuakeCoordinates
    let properties: FeatureProperties
    
    func from(feature: Feature) -> Quake {
        return Quake(magnitude: feature.properties.mag, place: feature.properties.place, time: feature.properties.time, tz: feature.properties.tz, detail: feature.properties.detail, coordinates: feature.geometry.coordinates, properties: feature.properties)
    }
}

struct FeatureProperties: Codable {
    let mag: Double
    let place: String
    let time: Int64
    let updated: Int64
    let tz: Int
    let url: String
    let detail: String
    let felt: Int
    let cdi: Double
    let mmi: Double
    let alert: String
    let status: String
    let tsunami: Int
    let sig: Int
    let net: String
    let code: String
    let ids: String
    let sources: String
    let types: String
    let nst: Int
    let dmin: Double
    let rms: Double
    let gap: Double
    let magType: String
    let type: FeatureType
}

struct FeatureGeometry: Codable {
    let type: EventType
    let coordinates: QuakeCoordinates
}

struct QuakeCoordinates: Codable {
    let longitude: Double
    let latitude: Double
    let depth: Double
}

