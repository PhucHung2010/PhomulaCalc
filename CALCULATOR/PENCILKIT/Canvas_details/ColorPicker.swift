import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    @Binding var uiColor: UIColor
    @State private var isDragging = false
    @Binding var dragOffset: CGFloat
    
    // Dải màu phổ cơ bản
    let gradientColors: [Color] = [.black, .white, .red, .orange, .yellow, .green, .blue, .purple]

    var body: some View {
        VStack {
            ZStack {
                // Phổ màu nền
                RoundedRectangle(cornerRadius: 30)
                    .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .leading, endPoint: .trailing))
                    .frame(height: 25)
                    .shadow(radius: 8)
                
                // Nút kéo
                HStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 35, height: 35)
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1.5)
                        )
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
                        .offset(x: dragOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    isDragging = true
                                    updateColor(at: value.location.x)
                                }
                                .onEnded { _ in
                                    isDragging = false
                                }
                        )
                        .animation(.easeInOut(duration: 0.15), value: dragOffset)
                        
                    Spacer()
                }
                
                // Hiển thị màu hiện tại trong nút kéo
                if isDragging {
                    selectedColor
                        .frame(width: 80, height: 20)
                        .cornerRadius(30)
                        .shadow(radius: 5)
                        .offset(x: dragOffset - (UIScreen.main.bounds.width / 2.45), y: -50)
                        .animation(.interactiveSpring(response: 0.5, dampingFraction: 0.3, blendDuration: 0.1), value: dragOffset)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: isDragging)
            .padding(.horizontal, 20)
        }
    }

    // Cập nhật màu sắc dựa trên vị trí kéo
    func updateColor(at position: CGFloat) {
        let width = UIScreen.main.bounds.width - 40 // Giới hạn phạm vi kéo
        let relativePosition = min(max(position, 0), width) / width
        let colorPosition = CGFloat(gradientColors.count - 1) * relativePosition
        let startIndex = Int(floor(colorPosition))
        let endIndex = Int(ceil(colorPosition))
        let startColor = UIColor(gradientColors[startIndex])
        let endColor = UIColor(gradientColors[endIndex])
        
        // Tính toán màu sắc dựa trên vị trí tương đối giữa hai màu
        let color = UIColor.interpolate(from: startColor, to: endColor, fraction: colorPosition - CGFloat(startIndex))
        uiColor = color
        selectedColor = Color(color)
        
        // Giới hạn vị trí kéo trong phạm vi của thanh phổ màu
        dragOffset = min(max(position - 20, 0), width - 35)
    }
}

// Tiện ích nội suy màu sắc
extension UIColor {
    static func interpolate(from color1: UIColor, to color2: UIColor, fraction: CGFloat) -> UIColor {
        var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let r = r1 + (r2 - r1) * fraction
        let g = g1 + (g2 - g1) * fraction
        let b = b1 + (b2 - b1) * fraction
        let a = a1 + (a2 - a1) * fraction

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}

struct TestColorPicker: View {
    @State private var selectedColor: Color = .blue
    @State private var dragOffset: CGFloat = 0.0
    @State private var uiColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    
    var body: some View {
        CustomColorPicker(selectedColor: $selectedColor, uiColor: $uiColor, dragOffset: $dragOffset)
    }
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        TestColorPicker()
    }
}
