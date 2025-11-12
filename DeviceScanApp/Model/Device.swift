//
//  Device.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import Foundation

protocol Device {
  var type: DeviceType { get }
  var id: UUID { get }
  var displayName: String { get }
  var date: String { get }
}

enum DeviceType {
  case bluetooth
  case wifi
}
