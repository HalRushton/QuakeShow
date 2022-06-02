//
//  Quake.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/1/22.
//

import Foundation

struct Quake {
    let magnitude: Double
    let place: String
    let time: Int64
    let tz: Int16
    let detail: String
    let coordinates: QuakeCoordinates
    let properties: FeatureProperties
}
