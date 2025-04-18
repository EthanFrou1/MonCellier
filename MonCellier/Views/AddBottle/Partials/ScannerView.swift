import SwiftUI

struct ScannerView: View {
    var onScan: (String) -> Void
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                // Dans une vraie application, on utiliserait AVFoundation pour scanner des codes-barres
                Color.black.opacity(0.8)
                
                VStack {
                    Rectangle()
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 250, height: 150)
                        .overlay(
                            Image(systemName: "barcode.viewfinder")
                                .font(.system(size: 100))
                                .foregroundColor(.white.opacity(0.5))
                        )
                    
                    Text("Placez le code-barres dans le cadre")
                        .foregroundColor(.white)
                        .padding()
                    
                    // Pour la simulation, permettre de "scanner" un code-barres fictif
                    Button(action: {
                        // Simuler un scan réussi
                        let mockBarcode = "3760123456789"
                        onScan(mockBarcode)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Simuler un scan")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            .navigationTitle("Scanner")
            Button("Annuler") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
    }
}
