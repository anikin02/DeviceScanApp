//
//  RealmModels.swift
//  DeviceScanApp
//
//  Created by Данил Аникин on 13/11/2025.
//

import Foundation
import RealmSwift

class BluetoothItemObject: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String?
    @Persisted var rssi: Int = 0
    @Persisted var isConnected: Bool = false
    @Persisted var date: String = ""
    
    convenience init(item: BluetoothItem) {
        self.init()
        self.id = item.id.uuidString
        self.name = item.name
        self.rssi = item.rssi
        self.isConnected = item.isConnected
        self.date = item.date
    }
    
    func toBluetoothItem() -> BluetoothItem {
        return BluetoothItem(
            name: name ?? "Unknown",
            id: UUID(uuidString: id) ?? UUID(),
            rssi: rssi,
            isConnected: isConnected,
            date: date
        )
    }
}

class WifiItemObject: Object {
    @Persisted(primaryKey: true) var id: String = UUID().uuidString
    @Persisted var name: String?
    @Persisted var ip: String = ""
    @Persisted var mac: String?
    @Persisted var date: String = ""
    
    convenience init(item: WifiItem) {
        self.init()
        self.id = item.id.uuidString
        self.name = item.name
        self.ip = item.ip
        self.mac = item.mac
        self.date = item.date
    }
    
    func toWifiItem() -> WifiItem {
        return WifiItem(
            id: UUID(uuidString: id) ?? UUID(),
            name: name,
            ip: ip,
            mac: mac,
            date: date
        )
    }
}
