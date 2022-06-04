//
//  SortView.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/3/22.
//

import Foundation
import SwiftUI
import Combine

struct SortView: View {
    @ObservedObject var viewModel: SortViewModel
    
    init(sortViewModel: SortViewModel) {
        self.viewModel = sortViewModel
    }
    
    var body: some View {
        Menu(content: {
            sortTypeButton(.magnitude)
            sortTypeButton(.name)
            sortTypeButton(.date)
        }, label: {
            Image(systemName: "arrow.up.arrow.down")
        })

    }
        
    @ViewBuilder func sortTypeButton(_ type: SortViewType) -> some View {
        Button(action: {
            if viewModel.sortViewType.wrappedValue == type {
                viewModel.sortAscending.wrappedValue = !viewModel.sortAscending.wrappedValue
            } else {
                viewModel.sortViewType.wrappedValue = type
                viewModel.sortAscending.wrappedValue = false
            }
        }, label: {
            if let imageName = viewModel.imageName(type: type) {
                Label(type.rawValue, systemImage: imageName)
            } else {
                Text(type.rawValue)
            }
        })
    }

}
