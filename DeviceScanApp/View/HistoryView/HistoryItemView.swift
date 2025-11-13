//
//  HistoryItemView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 12/11/2025.
//

import SwiftUI

struct HistoryItemView: View {
  let item: Device
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: item.type == .bluetooth ? "b.circle" : "wifi" )
        Text(item.displayName)
        Spacer()
      }
      HStack {
        Spacer()
        Text(item.date)
      }
    }
  }
}
