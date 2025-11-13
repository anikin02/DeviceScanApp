//
//  HistoryView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import SwiftUI

struct HistoryView: View {
  @ObservedObject var viewModel = HistoryViewModel()
  
  var body: some View {
    VStack() {
      VStack {
        if viewModel.items.isEmpty {
          VStack {
            Text("Oops. It's still empty.")
              .font(.system(size: 21, weight: .black))
          }
        } else {
          List(viewModel.items, id: \.id) { item in
            NavigationLink(destination: DetailsView(item: item)) {
              HistoryItemView(item: item)
            }
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
    .background(Color(UIColor.systemGroupedBackground))
  }
}

#Preview {
  HistoryView()
}
