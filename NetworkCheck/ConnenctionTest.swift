//
//  ConnenctionTest.swift
//  NetworkCheck
//
//  Created by Ala'a Araishi on 1/6/21.
//

import Foundation
import Network
import UIKit

class NetworkMonitor {
    static let shared = NetworkMonitor()
//    DispatchQueue : An FIFO object that manages the execution of tasks serially or
//    concurrently on your app's main thread or on a background thread.
    private let queue = DispatchQueue.global()

    private let monitor : NWPathMonitor
//  public private(set):  Public getter and Private setter
    public private(set) var isConnected: Bool = false
    
    private var status: NWPath.Status = .requiresConnection

    var connectionType : ConnectionType = .unknown

    enum ConnectionType{
        case wifi
        case cellular
        case unknown
    }
    private init (){
        monitor = NWPathMonitor()
    }
    func startMonitoring() {
        monitor.start(queue: queue)
        // this will work every time the connection status change!
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            
            self?.isConnected = path.status != .unsatisfied
            self?.getConnectionType(path)
            if path.status == .satisfied {
                print("We're connected!")

            } else {
                print("No connection.")
                // post disconnected notification
            }
            print(path.isExpensive)
        }
    }

    func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
                connectionType = .cellular
        }else {connectionType = .unknown}
        
    }
//    func topViewController() -> UIViewController? {
//        guard var topViewController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
//        while topViewController.presentedViewController != nil {
//            topViewController = topViewController.presentedViewController!
//        }
//        return topViewController
//    }
}
