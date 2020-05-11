//
//  RangeSlider.swift
//  Betterpick
//
//  Created by David Bielik on 02/05/2020.
//  Copyright © 2020 dvdblk. All rights reserved.
//

import UIKit

// Credits: https://github.com/warchimede/RangeSlider
// @warchimede
class RangeSlider: UIControl {

    // MARK: - Properties
    var minimumValue: Double = 0 {
        didSet {
            updateLayerFrames()
        }
    }

    var maximumValue: Double = 1 {
        didSet {
            updateLayerFrames()
        }
    }

    var lowerValue: Double = 0.2 {
        didSet {
            updateLayerFrames()
            generateFeedbackIfNeeded(oldValue: oldValue, newValue: lowerValue, boundaryValue: minimumValue, otherValue: upperValue)
        }
    }

    var upperValue: Double = 0.8 {
        didSet {
            updateLayerFrames()
            generateFeedbackIfNeeded(oldValue: oldValue, newValue: upperValue, boundaryValue: maximumValue, otherValue: lowerValue)
        }
    }

    var trackTintColor = UIColor.compatibleTertiarySystemFill {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    var trackHighlightTintColor = UIColor.primary {
        didSet {
            trackLayer.setNeedsDisplay()
        }
    }

    public var thumbTintColor: UIColor = UIColor.white {
        didSet {
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }

    public var curvaceousness: CGFloat = 1.0 {
        didSet {
            if curvaceousness < 0.0 {
                curvaceousness = 0.0
            }

            if curvaceousness > 1.0 {
                curvaceousness = 1.0
            }

            trackLayer.setNeedsDisplay()
            lowerThumbLayer.setNeedsDisplay()
            upperThumbLayer.setNeedsDisplay()
        }
    }

    // MARK: Fileprivate
    // last touch location in the view
    fileprivate var previouslocation = CGPoint()

    // CALayers
    fileprivate let trackLayer = RangeSliderTrackLayer()
    fileprivate let lowerThumbShadowLayer = RangeSliderThumbShadowLayer()
    fileprivate let lowerThumbLayer = RangeSliderThumbLayer()
    fileprivate let upperThumbShadowLayer = RangeSliderThumbShadowLayer()
    fileprivate let upperThumbLayer = RangeSliderThumbLayer()

    fileprivate var thumbWidth: CGFloat {
        return bounds.height - 12
    }

    // MARK: Overrides
    override public var frame: CGRect {
        didSet {
            updateLayerFrames()
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 36)
    }

    // MARK: Haptic Feedback
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // MARK: - Inherited
    // swiftlint:disable identifier_name
    override public func layoutSublayers(of: CALayer) {
        super.layoutSublayers(of: layer)
        updateLayerFrames()
    }
    // swiftlint:enable identifier_name

    // MARK: - Private
    private func setup() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.masksToBounds = false

        for sublayer in [trackLayer, lowerThumbShadowLayer, lowerThumbLayer, upperThumbShadowLayer, upperThumbLayer] {
            sublayer.contentsScale = UIScreen.main.scale
            layer.addSublayer(sublayer)
        }

        trackLayer.rangeSlider = self
        lowerThumbLayer.rangeSlider = self
        upperThumbLayer.rangeSlider = self

        if #available(iOS 13, *) {
            // Fix for parent panGestureRecognizers not cancelling the touches
            let panGesture = UIPanGestureRecognizer(target: nil, action: nil)
            panGesture.cancelsTouchesInView = false
            addGestureRecognizer(panGesture)
        }

        invalidateIntrinsicContentSize()
    }

    private func updateLayerFrames() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        trackLayer.frame = bounds.insetBy(dx: 0, dy: bounds.height*0.44)
        trackLayer.setNeedsDisplay()
        // Removes implicit animations
        trackLayer.removeAllAnimations()

        let yPos = (bounds.height - thumbWidth) / 2
        let lowerThumbCenter = CGFloat(positionForValue(lowerValue))
        lowerThumbLayer.frame = CGRect(x: lowerThumbCenter - thumbWidth/2.0, y: yPos, width: thumbWidth, height: thumbWidth)
        lowerThumbLayer.setNeedsDisplay()
        lowerThumbShadowLayer.frame = lowerThumbLayer.frame.insetBy(dx: -6, dy: -6)
        lowerThumbShadowLayer.setNeedsDisplay()

        let upperThumbCenter = CGFloat(positionForValue(upperValue))
        upperThumbLayer.frame = CGRect(x: upperThumbCenter - thumbWidth/2.0, y: yPos, width: thumbWidth, height: thumbWidth)
        upperThumbLayer.setNeedsDisplay()
        upperThumbShadowLayer.frame = upperThumbLayer.frame.insetBy(dx: -6, dy: -6)
        upperThumbShadowLayer.setNeedsDisplay()

        CATransaction.commit()
    }

    /// Generates haptic feedback
    private func generateFeedbackIfNeeded(oldValue: Double, newValue: Double, boundaryValue: Double, otherValue: Double) {
        guard isTracking, oldValue != newValue, newValue == otherValue || newValue == boundaryValue else { return }
        if #available(iOS 13, *) {
            impactFeedbackGenerator.impactOccurred(intensity: 0.8)
        } else {
            impactFeedbackGenerator.impactOccurred()
        }
    }

    func positionForValue(_ value: Double) -> Double {
        return Double(bounds.width - thumbWidth) * (value - minimumValue) /
            (maximumValue - minimumValue) + Double(thumbWidth/2.0)
    }

    func boundValue(_ value: Double, toLowerValue lowerValue: Double, upperValue: Double) -> Double {
        return min(max(value, lowerValue), upperValue)
    }

    // MARK: - Touches
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        previouslocation = touch.location(in: self)

        // Hit test the thumb layers
        let outsideMargin: CGFloat = 6
        let upperThumbLayerHitTestFrame = upperThumbLayer.frame.insetBy(dx: -outsideMargin, dy: -outsideMargin)
        let lowerThumbLayerHitTestFrame = lowerThumbLayer.frame.insetBy(dx: -outsideMargin, dy: -outsideMargin)
        if lowerThumbLayerHitTestFrame.contains(previouslocation) {
            lowerThumbLayer.highlighted = true
        }
        if upperThumbLayerHitTestFrame.contains(previouslocation) {
            upperThumbLayer.highlighted = true
        }

        let beginTracking = lowerThumbLayer.highlighted || upperThumbLayer.highlighted
        if beginTracking {
            impactFeedbackGenerator.prepare()
        }
        return beginTracking
    }

    override public func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)

        // Determine by how much the user has dragged
        let deltaLocation = Double(location.x - previouslocation.x)
        let deltaValue = (maximumValue - minimumValue) * deltaLocation / Double(bounds.width - bounds.height)

        let bothHighlighted = lowerThumbLayer.highlighted && upperThumbLayer.highlighted
        if bothHighlighted {
            let absDistance = abs(location.x - previouslocation.x)
            guard absDistance > 8 else { return true }

            let isTrackingToRight = location.x - previouslocation.x > 0
            if isTrackingToRight {
                // We're tracking to the right, highlight only the upperThumbLayer
                lowerThumbLayer.highlighted = false
            } else {
                // We're tracking to the left, highlight only the lowerThumbLayer
                upperThumbLayer.highlighted = false
            }
        }

        previouslocation = location
        // Update the values
        if lowerThumbLayer.highlighted {
            // Make sure we're tracking only inside the UIView
            if lowerValue == minimumValue {
                guard location.x > 0 else { return true }
            }

            if lowerValue == upperValue {
                guard location.x <= upperThumbLayer.frame.origin.x + thumbWidth/2 else { return true }
            }
            lowerValue = boundValue(lowerValue + deltaValue, toLowerValue: minimumValue, upperValue: upperValue)
        } else if upperThumbLayer.highlighted {
            // Make sure we're tracking only inside the UIView
            if upperValue == maximumValue {
                guard location.x < bounds.width else { return true }
            }

            if lowerValue == upperValue {
                guard location.x >= lowerThumbLayer.frame.origin.x + thumbWidth/2 else { return true }
            }
            upperValue = boundValue(upperValue + deltaValue, toLowerValue: lowerValue, upperValue: maximumValue)
        }

        sendActions(for: .valueChanged)

        return true
    }

    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        lowerThumbLayer.highlighted = false
        upperThumbLayer.highlighted = false
    }
}

class RangeSliderTrackLayer: CALayer {
    weak var rangeSlider: RangeSlider?

    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else {
            return
        }

        // Clip
        let cornerRadius = bounds.height * slider.curvaceousness / 2.0
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        ctx.addPath(path.cgPath)

        // Fill the track
        ctx.setFillColor(slider.trackTintColor.cgColor)
        ctx.addPath(path.cgPath)
        ctx.fillPath()

        // Fill the highlighted range
        ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
        let lowerValuePosition = CGFloat(slider.positionForValue(slider.lowerValue))
        let upperValuePosition = CGFloat(slider.positionForValue(slider.upperValue))
        let rect = CGRect(x: lowerValuePosition, y: 0.0, width: upperValuePosition - lowerValuePosition, height: bounds.height)
        ctx.fill(rect)
    }
}

class RangeSliderThumbLayer: CALayer {

    // MARK: - Properties
    var highlighted: Bool = false
    weak var rangeSlider: RangeSlider?

    // MARK: - Inherited
    override func draw(in ctx: CGContext) {
        guard let slider = rangeSlider else {
            return
        }

        let cornerRadius = bounds.height * slider.curvaceousness / 2.0
        let thumbPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        // Fill
        ctx.setFillColor(slider.thumbTintColor.cgColor)
        ctx.addPath(thumbPath.cgPath)
        ctx.fillPath()
    }
}

class RangeSliderThumbShadowLayer: CALayer {

    override func draw(in ctx: CGContext) {
        let cornerRadius = bounds.height / 2.0
        let thumbPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 6, dy: 6), cornerRadius: cornerRadius)

        // Shadow
        ctx.setStrokeColor(UIColor.white.cgColor)
        ctx.setShadow(offset: CGSize(width: 0, height: 0.5), blur: 4, color: UIColor.black.withAlphaComponent(0.40).cgColor)
        ctx.setLineWidth(1)
        ctx.setBlendMode(.multiply)
        ctx.addPath(thumbPath.cgPath)
        ctx.strokePath()
    }
}
