//
//  BluetoothScan.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 13/11/2025.
//

import CoreBluetooth
import Foundation

enum BluetoothScanError: Error {
  case bluetoothUnavailable
  case unauthorized
  case unsupported
}

class BluetoothScan: NSObject, CBCentralManagerDelegate {
  private var centralManager: CBCentralManager!
  private var discoveredItems: [BluetoothItem] = []
  private var completion: (([BluetoothItem]) -> Void)?
  private var scanDuration: TimeInterval = 10
  
  override init() {
    super.init()
  }
  
  func scanForDevices(duration: TimeInterval = 10, completion: @escaping ([BluetoothItem]) -> Void) {
    self.completion = completion
    self.scanDuration = duration
    
    if centralManager == nil {
        print("🟢 Creating CBCentralManager...")
        centralManager = CBCentralManager(delegate: self, queue: DispatchQueue.main)
    }
    
    // Проверяем текущую авторизацию
    if #available(iOS 13.0, *) {
      switch CBCentralManager.authorization {
      case .notDetermined:
        print("📩 Запрос разрешения появится автоматически при создании CBCentralManager")
        // Дальше будем ждать вызова centralManagerDidUpdateState
      case .denied:
        print("🚫 Bluetooth доступ запрещён. Нужно включить в Настройках")
        completion([])
        return
      case .allowedAlways:
        print("✅ Bluetooth разрешён")
      @unknown default:
        print("❓ Неизвестное состояние авторизации")
        completion([])
        return
      }
    }
    
    // Если Bluetooth уже включён — можно сразу сканировать
    if centralManager.state == .poweredOn {
      startScan()
    } else {
      print("⏳ Waiting for Bluetooth to power on...")
    }
  }
  
  private func startScan() {
    print("🔍 Starting scan...")
    discoveredItems.removeAll()
    
    // Сканируем все устройства
    centralManager.scanForPeripherals(withServices: nil, options: nil)
    
    // Остановим сканирование через заданное время
    DispatchQueue.main.asyncAfter(deadline: .now() + scanDuration) { [weak self] in
      guard let self = self else { return }
      self.centralManager.stopScan()
      self.completion?(self.discoveredItems)
    }
  }
  
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    switch central.state {
    case .poweredOn:
      print("✅ Bluetooth is powered on")
      if completion != nil {
        startScan()
      }
    case .poweredOff:
      print("⚠️ Bluetooth is turned off")
      completion?([])
    case .unauthorized:
      print("🚫 Bluetooth permission denied")
      completion?([])
    case .unsupported:
      print("❌ Bluetooth unsupported")
      completion?([])
    default:
      print("⏳ Bluetooth not ready: \(central.state.rawValue)")
    }
  }
  
  func centralManager(_ central: CBCentralManager,
                      didDiscover peripheral: CBPeripheral,
                      advertisementData: [String : Any],
                      rssi RSSI: NSNumber) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    
    let item = BluetoothItem(
      name: peripheral.name ?? "Unknown",
      id: peripheral.identifier,     // UUID
      rssi: RSSI.intValue,           // RSSI как Int
      isConnected: peripheral.state == .connected,
      date: formatter.string(from: Date())
    )
    
    // Проверяем, что такого устройства ещё нет
    if !discoveredItems.contains(where: { $0.id == item.id }) {
      discoveredItems.append(item)
    }
  }
}
