import SwiftUI

struct RatingView: View {
    @Binding var rating: Float
    let maximumRating = 5
    var size: CGFloat = 24
    var interactive: Bool = true
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(1...maximumRating, id: \.self) { number in
                image(for: number)
                    .font(.system(size: size))
                    .foregroundColor(number <= Int(self.rating) ? .yellow : .gray)
                    .onTapGesture {
                        if interactive {
                            withAnimation(.spring()) {
                                self.rating = Float(number)
                                // Retour haptique
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                            }
                        }
                    }
                    .accessibility(label: Text("Note de \(number) sur 5"))
                    .scaleEffect(interactive && isHalfStar(number) ? 1.2 : 1.0)
                    .shadow(color: number <= Int(self.rating) ? .yellow.opacity(0.4) : .clear, radius: 1)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibility(label: Text("Note: \(Int(rating)) sur 5 étoiles"))
    }
    
    func image(for number: Int) -> Image {
        if number <= Int(rating) {
            return Image(systemName: "star.fill")
        } else if number == Int(rating) + 1 && isHalfStar(number) {
            return Image(systemName: "star.leadinghalf.filled")
        } else {
            return Image(systemName: "star")
        }
    }
    
    func isHalfStar(_ number: Int) -> Bool {
        let decimalPart = rating - Float(Int(rating))
        return number == Int(rating) + 1 && decimalPart >= 0.3 && decimalPart < 0.7
    }
}
