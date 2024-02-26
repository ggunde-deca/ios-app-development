//
//  ContentView.swift
//  passingdata
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI

struct ContentView: View {
    @State var text2: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "hands.clap")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                TextField("Input Text", text: $text2)
                    .border(.secondary)
                    .padding()
                NavigationLink(destination: Page2View(text3: $text2)) {
                    Label("Go to Page 2", systemImage: "rectangle.portrait.and.arrow.forward")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
    }
    
}


#Preview {
    ContentView()
}
