//
//  Grateful_MomentsApp.swift
//  Grateful Moments
//
//  Created by Abdul Moiz on 25/04/2026.
//

import SwiftUI
import SwiftData

@main
struct Grateful_MomentsApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}
