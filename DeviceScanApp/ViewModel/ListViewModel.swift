//
//  ListViewModel.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import Foundation
import Lottie

class ListViewModel: ObservableObject {
  @Published var devices: [Device] = []
  @Published var scanStatus: ScanStatus = .waiting
  
  func scan() {
    
    if scanStatus == .waiting || scanStatus == .wrong {
      scanStatus = .scanning
    } else if scanStatus == .scanning  {
      scanStatus = .success
    } else
    {
      scanStatus = .wrong
    }
    
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
