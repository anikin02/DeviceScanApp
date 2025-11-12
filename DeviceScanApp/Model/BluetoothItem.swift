//
//  BluetoothItem.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import Foundation

struct BluetoothItem: Device {
  
  var type: DeviceType = .bluetooth
  var name: String
  var id: UUID
  var rssi: Int
  var isConnected: Bool
  var date: String
  
  var displayName: String {
    name
  }
}
