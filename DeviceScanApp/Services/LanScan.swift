//
//  LanScan.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 13/11/2025.
//

import Foundation
import MMLanScan

class LanScan: NSObject {
  var devices: [WifiItem] = []
  private var scanner: MMLANScanner?
  private var isScanning = false
  
  override init() {
    super.init()
    scanner = MMLANScanner(delegate: self)
  }
  
  func start() {
    devices = []
    isScanning = true
    print("Начало сканирования LAN")
    
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else { return }
      self.scanner?.start()
      DispatchQueue.global().asyncAfter(deadline: .now() + 5) { [weak self] in
        guard let self = self else { return }
        if self.isScanning {
          self.stop()
        }
      }
    }
  }
  
  func stop() {
    scanner?.stop()
    isScanning = false
    print("Сканирование остановлено")
  }
}

extension LanScan: MMLANScannerDelegate {
  func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
    isScanning = false
    
    let statusStr: String
    switch status {
    case MMLanScannerStatusFinished:
      statusStr = "успешно"
    case MMLanScannerStatusCancelled:
      statusStr = "отменено"
    default:
      statusStr = "неизвестно"
    }
    
    print("Сканирование завершено, статус: \(statusStr)")
  }
  
  func lanScanDidFindNewDevice(_ device: MMDevice!) {
    guard let device = device else { return }
    let ip = device.ipAddress ?? ""
    let mac = device.macAddress
    let name = device.hostname
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    
    let item = WifiItem(name: name, ip: ip, mac: mac, date: formatter.string(from: Date()))
    if !devices.contains(where: { $0.ip == ip }) {
      devices.append(item)
      let macStr = mac ?? "неизвестно"
      let nameStr = name ?? "неизвестно"
      print("Найдено устройство: IP=\(ip), MAC=\(macStr), Name=\(nameStr)")
    }
  }
  
  func lanScanDidFinishScanning(with status: Bool) {
    isScanning = false
    let statusStr = status ? "успешно" : "с ошибкой"
    print("Сканирование завершено, статус: \(statusStr)")
  }
  
  func lanScanDidFailedToScan() {
    isScanning = false
    print("Ошибка сканирования")
  }
}
