//
//  Page2View.swift
//  passingdata
//
//  Created by Harnoor Singh on 2/24/24.
//

import SwiftUI

struct Page2View: View {
    @Binding var text3: String
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .scaledToFit()
                AsyncImage(url: URL(string: text3)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 150)
                } placeholder: {
                    ProgressView()
                }
                Text("Received from Page 1 \(text3)")
                NavigationLink(destination: Page3View(text4: $text3)) {
                    Label("Enlarge Image", systemImage: "rectangle.portrait.and.arrow.forward")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
            }
            .padding()
        }
    }
}


#Preview {
    Page2View(text3: .constant("Hello"))
}
