//
//  DeviceRealmManager.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 13/11/2025.
//

import RealmSwift

class RealmManager {
  static let shared = RealmManager()
  
  private let realm = try! Realm()
  
  private init() {}
  
  func save(_ device: Device) {
    try! realm.write {
      if let bluetooth = device as? BluetoothItem {
        let obj = BluetoothItemObject(item: bluetooth)
        realm.add(obj, update: .modified)
      } else if let wifi = device as? WifiItem {
        let obj = WifiItemObject(item: wifi)
        realm.add(obj, update: .modified)
      }
    }
  }
  
  func getAllDevices() -> [Device] {
    let bluetoothItems = realm.objects(BluetoothItemObject.self)
      .map { $0.toBluetoothItem() }        
    let wifiItems = realm.objects(WifiItemObject.self)
      .map { $0.toWifiItem() }
    
    let allDevices: [Device] = Array(bluetoothItems) + Array(wifiItems)
    
    return allDevices.sorted { $0.date > $1.date }
  }
}
