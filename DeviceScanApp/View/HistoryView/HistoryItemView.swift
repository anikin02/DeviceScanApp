//
//  HistoryItemView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 12/11/2025.
//

import SwiftUI

struct HistoryItemView: View {
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "wifi")
        Text("255.255.255.255")
        Spacer()
      }
      HStack {
        Spacer()
        Text("12.11.25")
      }
    }
    VStack(alignment: .leading) {
      HStack {
        Image(systemName: "b.circle")
        Text("255.255.255.255")
        Spacer()
      }
      HStack {
        Spacer()
        Text("12.11.25")
      }
    }
  }
}
