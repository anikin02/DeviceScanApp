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
        if !viewModel.items.isEmpty {
          VStack {
            Text("Oops. It's still empty.")
              .font(.system(size: 21, weight: .black))
          }
        } else {
          List {
            HistoryItemView()
            HistoryItemView()
            HistoryItemView()
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
