//
//  Device.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

protocol Device {
  var name: String { get }
  var address: String { get }
  var type: DeviceType { get }
}

enum DeviceType {
  case bluetooth
  case wifi
}
