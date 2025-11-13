//
//  DetailsView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 13/11/2025.
//

import SwiftUI

struct DetailsView: View {
  let item: Device
  var body: some View {
    VStack {
      if item is WifiItem {
        getLanView(device: item as! WifiItem)
      } else if item is BluetoothItem {
        getBluetoothView(device: item as! BluetoothItem)
      }
    }
    .navigationTitle(item.displayName)
  }
  
  private func getLanView(device: WifiItem) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("Lan")
          .font(.system(size: 30, weight: .black))
        Image(systemName: "wifi")
      }
      Text("Name: \(device.name ?? "Unknown")")
        .font(.system(size: 21, weight: .regular))
      Text("Mac: \(device.mac ?? "Unknown")")
        .font(.system(size: 21, weight: .regular))
      Text("Date: \(device.date)")
        .font(.system(size: 21, weight: .regular))
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
  }
  
  private func getBluetoothView(device: BluetoothItem) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack {
        Text("Bluetooth")
          .font(.system(size: 30, weight: .black))
        Image(systemName: "b.circle")
      }
      Text("RSSI: \(device.rssi)")
        .font(.system(size: 21, weight: .regular))
      Text("Is connected: \(device.isConnected ? "Yes" : "No")")
        .font(.system(size: 21, weight: .regular))
      Text("Date: \(device.date)")
        .font(.system(size: 21, weight: .regular))
      Spacer()
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
  }
}

#Preview {
  NavigationView {
    DetailsView(item: BluetoothItem(type: .bluetooth, name: "Name", id: UUID(), rssi: 10, isConnected: true, date: "22.11.14"))
  }
}
