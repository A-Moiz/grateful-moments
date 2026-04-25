//
//  DataContainer.swift
//  Grateful Moments
//
//  Created by Abdul Moiz on 25/04/2026.
//

import SwiftData
import SwiftUI

// Marks the class so SwiftUI can track changes to its properties
@Observable
// Ensures all operations in this class run on the main thread
@MainActor
class DataContainer {
    // Swift data database
    let modelContainer: ModelContainer
    
    // Computed variable which return model containers main context. This is needed to insert data, delete data etc.
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    // Set up database when a new DataContainer is created
    init(includeSampleMoments: Bool = false) {
        // Which models will be stored in the database, currently just Moment
        let schema = Schema([
            Moment.self,
        ])
        
        // Configures settings, whether to save data permanently or just in memory
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        
        do {
            // Attempts to initalise the database with the schema and settings
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            // Checks if the option to include sample data was chosen (true) or not (false)
            if includeSampleMoments {
                // Fills the database with the example data
                loadSampleMoments()
            }
            
            // Finalises the changes by saving the current state
            try context.save()
        } catch {
            // Stops the app and shows an error if the database fails to start
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    // Inserts each moment in sample data into the context
    private func loadSampleMoments() {
        for moment in Moment.sampleData {
            context.insert(moment)
        }
    }
}

// Single shared instance of the container pre-filled with sample data
private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    // Helper function to inject sample database into SwiftUI Views
    func sampleDataContainer() -> some View {
        self
        // Makes the DataContainer class available to the view's environment
            .environment(sampleContainer)
        // Attaches the SwiftData container so @Query can work in views
            .modelContainer(sampleContainer.modelContainer)
    }
}
