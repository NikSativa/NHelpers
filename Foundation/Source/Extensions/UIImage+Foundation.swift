import UIKit

public extension UIImage {
    static func gradient(colors: (from: UIColor, to: UIColor), locations: (start: CGPoint, end: CGPoint), size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            let colors = [colors.from.cgColor, colors.to.cgColor]
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let colorLocations: [CGFloat] = [0.0, 1.0]
            if let gradient = CGGradient(colorsSpace: colorSpace,
                                         colors: colors as CFArray,
                                         locations: colorLocations) {
                context.cgContext.drawLinearGradient(gradient,
                                                     start: locations.start,
                                                     end: locations.end,
                                                     options: [])
            }
        }
    }

    static func colored(_ color: UIColor, size: CGSize = .init(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }

    func cropped(to rect: CGRect) -> UIImage {
        guard let cgImage = cgImage, let imageRef = cgImage.cropping(to: rect) else {
            return UIImage()
        }

        return UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
    }

    func resized(to newSize: CGSize) -> UIImage {
        let scaledSize = newSize.applying(.init(scaleX: 1 / scale, y: 1 / scale))

        return UIGraphicsImageRenderer(size: scaledSize).image { _ in
            draw(in: .init(origin: .zero, size: scaledSize))
        }
    }
}
