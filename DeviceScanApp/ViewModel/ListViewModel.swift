//
//  ListViewModel.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import Foundation
import Lottie
import CoreBluetooth

class ListViewModel: ObservableObject {
  @Published var devices: [Device] = []
  @Published var scanStatus: ScanStatus = .waiting
  
  private var bluetoothScanner: BluetoothScan?
  private var lanScanner: LanScan?
  
  func scan() {
    scanStatus = .scanning
    devices = []
    
    let group = DispatchGroup()
    
    var allDevices: [Device] = []
    
    // Bluetooth
    group.enter()
    bluetoothScanner = BluetoothScan()
    bluetoothScanner?.scanForDevices { result in
      allDevices.append(contentsOf: result)
      group.leave()
    }
    
    // LAN
    group.enter()
    lanScanner = LanScan()
    lanScanner?.start()
    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
      if let lanDevices = self.lanScanner?.devices {
        allDevices.append(contentsOf: lanDevices)
      }
      group.leave()
    }
    
    // Когда оба сканирования завершены
    group.notify(queue: .main) { [weak self] in
      guard let self = self else { return }
      self.devices = allDevices.sorted { $0.date > $1.date }
      self.scanStatus = .success
      print("Сканирование завершено, найдено устройств: \(allDevices.count)")
    }
  }
  
  private func save() {
    
  }
  
  
}

enum ScanStatus {
  case waiting
  case scanning
  case success
  case wrong
}
