//
//  ViewController.swift
//  Numeron
//
//  Created by Wang Shuwei on 2018/5/12.
//  Copyright © 2018 Codingpotato. All rights reserved.
//

import UIKit

private let IMAGE_SIZE = 28

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var canvasView: CanvasView!
    
    @IBAction func evaluateButtonPressed(_ sender: Any) {
        UIGraphicsBeginImageContext(canvasView.frame.size)
        canvasView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let rawImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIGraphicsBeginImageContext(CGSize(width: IMAGE_SIZE, height: IMAGE_SIZE))
        rawImage.draw(in: CGRect(x: 0, y: 0, width: IMAGE_SIZE, height: IMAGE_SIZE))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let cgImage = image.cgImage!
        let pixelData = cgImage.dataProvider!.data
        let data = CFDataGetBytePtr(pixelData)!
        
        var imageData = [Double]()
        for row in 0..<IMAGE_SIZE {
            for col in 0..<IMAGE_SIZE {
                let index = cgImage.bytesPerRow * row + cgImage.bitsPerPixel / 8 * col
                imageData.append(Double(data[index]) / 255)
            }
        }
        
        label.text = "\(evaluateData(imageData))"
    }
    
    @IBAction func clearButtonPressed(_ sender: Any) {
        canvasView.clear()
    }
    
    private func evaluateData(_ data: [Double]) -> Int {
        precondition(data.count == IMAGE_SIZE * IMAGE_SIZE)
        
        //print(data)
        
        return 0
    }
    
}

