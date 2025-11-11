//
//  BluetoothItem.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

struct BluetoothItem: Device {
  var type: DeviceType = .bluetooth
  
  var name: String
  var address: String
}
