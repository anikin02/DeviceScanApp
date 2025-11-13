//
//  HistoryViewModel.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 12/11/2025.
//

import Foundation

class HistoryViewModel: ObservableObject {
  @Published var items = [Device]()
  
  init() {
    loadData()
  }
  
  func loadData() {
    DispatchQueue.main.async {
      self.items = RealmManager.shared.getAllDevices()
    }
  }
}
