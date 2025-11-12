//
//  WifiItem.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import Foundation

struct WifiItem: Device {
  var type: DeviceType = .wifi
  var id = UUID()
  var name: String?
  var ip: String
  var mac: String?
  var date: String
  
  var displayName: String {
    name ?? ip
  }
}
