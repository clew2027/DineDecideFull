//
//  DineDecideApp.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//

import SwiftUI

@main
struct DineDecideApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(locationManager)
                .onAppear {
                    locationManager.requestLocation()
                }
        }
    }
}
