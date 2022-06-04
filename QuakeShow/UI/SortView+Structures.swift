//
//  SortView+structures.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/3/22.
//

import Foundation

enum SortViewType: String {
    case magnitude = "Magnitude"
    case date = "Date"
    case name = "Name"
}

struct SortInfo {
    let type: SortViewType
    let ascending: Bool
}
