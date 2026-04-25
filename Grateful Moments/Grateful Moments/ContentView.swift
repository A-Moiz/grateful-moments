//
//  ContentView.swift
//  Grateful Moments
//
//  Created by Abdul Moiz on 25/04/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        VStack {
            Button("Create a Greateful Moment") {
                isPresented = true
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $isPresented) {
                MomentEntryView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
