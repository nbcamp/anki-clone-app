import UIKit

@objc protocol CircularProgressViewDelegate {
    @objc optional func innerView(_ view: UIView)
}

final class CircularProgressView: UIView {
    var size: CGFloat = 0 {
        didSet { frame.size = .init(width: size, height: size) }
    }

    var color: UIColor = .black
    var lineWidth: CGFloat = 0.15

    private(set) var progress: CGFloat = .zero

    weak var delegate: CircularProgressViewDelegate?

    private let circularLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    func progress(_ progress: CGFloat, animated: Bool = false) {
        CATransaction.begin()
        CATransaction.setDisableActions(!animated)
        self.progress = progress
        progressLayer.strokeEnd = progress
        CATransaction.commit()
    }

    func draw() {
        let radius = size / 2
        let lineWidth = radius * lineWidth
        let circularPath = UIBezierPath(
            arcCenter: .init(x: radius, y: radius),
            radius: radius - (lineWidth / 2),
            startAngle: CGFloat(-Double.pi / 2),
            endAngle: CGFloat(3 * Double.pi / 2),
            clockwise: true
        )
        circularLayer.path = circularPath.cgPath
        circularLayer.fillColor = UIColor.clear.cgColor
        circularLayer.lineCap = .round
        circularLayer.lineWidth = lineWidth
        circularLayer.strokeEnd = 1.0
        circularLayer.strokeColor = color.withAlphaComponent(0.2).cgColor
        layer.addSublayer(circularLayer)

        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color.cgColor
        layer.addSublayer(progressLayer)

        if delegate?.innerView != nil {
            let innerView = {
                let innerOrigin = lineWidth
                let gap: CGFloat = 20
                let innerSize = (frame.width - innerOrigin * 2) - gap
                let innerView = UIView(frame: .init(x: innerOrigin + gap / 2, y: innerOrigin + gap / 2, width: innerSize, height: innerSize))
                innerView.layer.cornerRadius = innerSize / 2
                innerView.layer.masksToBounds = true
                return innerView
            }()
            delegate?.innerView?(innerView)
            addSubview(innerView)
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        draw()
    }
}
