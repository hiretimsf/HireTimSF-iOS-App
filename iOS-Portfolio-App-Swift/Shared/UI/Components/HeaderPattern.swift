import SwiftUI

struct HeaderPattern: View {
    private let points: [CGPoint] = [
        CGPoint(x: -0.08, y: -0.04), CGPoint(x: 0.08, y: -0.03), CGPoint(x: 0.24, y: -0.05),
        CGPoint(x: 0.43, y: -0.03), CGPoint(x: 0.61, y: -0.05), CGPoint(x: 0.80, y: -0.03),
        CGPoint(x: 1.05, y: -0.02), CGPoint(x: -0.04, y: 0.18), CGPoint(x: 0.10, y: 0.07),
        CGPoint(x: 0.23, y: 0.22), CGPoint(x: 0.34, y: 0.10), CGPoint(x: 0.48, y: 0.23),
        CGPoint(x: 0.63, y: 0.11), CGPoint(x: 0.78, y: 0.23), CGPoint(x: 0.94, y: 0.12),
        CGPoint(x: 1.05, y: 0.25), CGPoint(x: -0.03, y: 0.42), CGPoint(x: 0.12, y: 0.34),
        CGPoint(x: 0.25, y: 0.47), CGPoint(x: 0.38, y: 0.35), CGPoint(x: 0.50, y: 0.48),
        CGPoint(x: 0.64, y: 0.36), CGPoint(x: 0.78, y: 0.49), CGPoint(x: 0.91, y: 0.38),
        CGPoint(x: 1.04, y: 0.47), CGPoint(x: -0.04, y: 0.67), CGPoint(x: 0.10, y: 0.78),
        CGPoint(x: 0.22, y: 0.63), CGPoint(x: 0.35, y: 0.74), CGPoint(x: 0.47, y: 0.61),
        CGPoint(x: 0.59, y: 0.75), CGPoint(x: 0.72, y: 0.62), CGPoint(x: 0.86, y: 0.72),
        CGPoint(x: 1.03, y: 0.63), CGPoint(x: -0.02, y: 0.95), CGPoint(x: 0.14, y: 1.04),
        CGPoint(x: 0.25, y: 0.88), CGPoint(x: 0.40, y: 1.02), CGPoint(x: 0.54, y: 0.88),
        CGPoint(x: 0.68, y: 1.03), CGPoint(x: 0.82, y: 0.88), CGPoint(x: 0.96, y: 1.02),
        CGPoint(x: 1.08, y: 0.82)
    ]

    var body: some View {
        Canvas { context, size in
            let scaled = points.map { CGPoint(x: $0.x * size.width, y: $0.y * size.height) }
            let maxDistance = min(size.width, size.height) * 0.42

            var path = Path()
            for startIndex in scaled.indices {
                for endIndex in scaled.indices.dropFirst(startIndex + 1) {
                    let start = scaled[startIndex]
                    let end = scaled[endIndex]
                    let distance = hypot(end.x - start.x, end.y - start.y)

                    if distance <= maxDistance {
                        path.move(to: start)
                        path.addLine(to: end)
                    }
                }
            }
            context.stroke(path, with: .color(.white), lineWidth: 0.7)

            for (index, point) in scaled.enumerated() {
                let radius: CGFloat = index % 7 == 0 ? 3.9 : 2.7
                let rect = CGRect(x: point.x - radius, y: point.y - radius, width: radius * 2, height: radius * 2)
                context.fill(Path(ellipseIn: rect), with: .color(.white))
            }
        }
    }
}
