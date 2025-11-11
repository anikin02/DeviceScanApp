//
//  ListViewModel.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import Foundation

class ListViewModel: ObservableObject {
  @Published var devices: [Device] = []
  @Published var scanStatus: ScanStatus = .waiting
  
  func scan() {
    scanStatus = .scanning
    save()
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
