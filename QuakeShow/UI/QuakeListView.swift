//
//  QuakeListView.swift
//  QuakeShow
//
//  Created by Hal Jay Rushton on 6/4/22.
//

import Foundation
import SwiftUI

struct QuakeListView: View {
    @ObservedObject var viewModel: QuakeListViewModel
    
    var body: some View {
            List {
                ForEach(viewModel.searchResults, id:
                        \.title) { quake in
                    NavigationLink(destination: {
                        Text(quake.title ?? "unknown")
                    }, label: {
                        Text(quake.title ?? "unknown")
                    })
                }
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    SortView(sortViewModel: SortViewModel(sortViewType: $viewModel.sortType, sortAscending: $viewModel.sortAscending))
                }

            }
    }

}
