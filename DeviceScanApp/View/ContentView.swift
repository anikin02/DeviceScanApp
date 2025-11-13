//
//  ContentView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      NavigationView {
        ListView()
      }
      .tabItem {
        Label("Scan", systemImage: "magnifyingglass")
      }
      NavigationView {
        HistoryView()
      }
      .tabItem {
        Label("History", systemImage: "list.bullet")
      }
    }
  }
}

#Preview {
  ContentView()
}
