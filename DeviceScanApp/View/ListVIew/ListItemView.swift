//
//  ListItemView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import SwiftUI

struct ListItemView: View {
  let item: Device
  var body: some View {
    HStack {
      Image(systemName: item.type == .bluetooth ? "b.circle" : "wifi")
      if let bluetooth = item as? BluetoothItem {
        Text(bluetooth.name ?? "Unknown")
      } else if let wifi = item as? WifiItem {
        Text(wifi.ip)
      }
    }
  }
}
