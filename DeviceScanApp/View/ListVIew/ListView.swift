//
//  ListView.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 11/11/2025.
//

import SwiftUI
import Lottie

struct ListView: View {
  @ObservedObject var viewModel = ListViewModel()
  
  var body: some View {
    
    VStack() {
      VStack {
        switch viewModel.scanStatus {
        case .waiting:
          Text("Press the button to scan")
            .font(.system(size: 21, weight: .black))
        case .scanning:
          LottieView(animation: .named("Searching Animation"))
            .playing(loopMode: .loop)
        case .success:
          List {
            ListItemView()
            ListItemView()
            ListItemView()
          }
          
        case .wrong:
          VStack {
            Image(systemName: "xmark.circle")
              .resizable()
              .frame(width: 50, height: 50)
              .foregroundStyle(.red)
            Text("Try again")
              .font(.system(size: 21, weight: .black))
          }
        }
      }
      .frame(maxHeight: .infinity, alignment: .center)
      
      Button {
        viewModel.scan()
      } label: {
        Text(viewModel.scanStatus == .scanning ? "Scanning..." : "Press to scan")
          .frame(maxWidth: .infinity)
          .padding(.vertical, 5)
      }
      .disabled(viewModel.scanStatus == .scanning)
      .buttonStyle(.borderedProminent)
      .padding(.vertical)
      .padding(.horizontal, 30)
    }
    .background(Color(UIColor.systemGroupedBackground))
  }
}

#Preview {
  NavigationView {
    ListView()
      .navigationTitle(Text("Scan"))
  }
}
