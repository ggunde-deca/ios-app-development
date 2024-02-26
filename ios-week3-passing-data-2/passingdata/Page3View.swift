import SwiftUI

struct Page3View: View {
    @Binding var text4: String
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
                .scaledToFit()
            AsyncImage(url: URL(string: text4)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: 600, height: 300)
            } placeholder: {
                ProgressView()
            }
            Text("Received from Page 2 \(text4)")
        }
        .padding()
    }
}


#Preview {
    Page3View(text4: .constant("Hello"))
}
