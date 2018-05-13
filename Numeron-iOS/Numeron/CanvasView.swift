//
//  CanvasView.swift
//  Numeron
//
//  Created by Wang Shuwei on 2018/5/12.
//  Copyright © 2018 Codingpotato. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    private var canvasPath = CGMutablePath()
    private var canvasLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configLayer()
    }
    
    func clear() {
        canvasPath = CGMutablePath()
        canvasLayer.path = canvasPath
    }
    
    private func configLayer() {
        layer.addSublayer(canvasLayer)
        canvasLayer.frame = layer.bounds
        canvasLayer.strokeColor = UIColor.white.cgColor
        canvasLayer.lineWidth = bounds.size.width / 15
        canvasLayer.lineCap = kCALineCapRound
        canvasLayer.lineJoin = kCALineJoinRound
        canvasLayer.path = canvasPath
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let loc = touches.first?.location(in: self) {
            canvasPath.move(to: loc)
        }
        canvasLayer.path = canvasPath
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let loc = touches.first?.location(in: self) {
            canvasPath.addLine(to: loc)
        }
        canvasLayer.path = canvasPath
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let loc = touches.first?.location(in: self) {
            canvasPath.addLine(to: loc)
        }
        canvasLayer.path = canvasPath
    }
    
}
