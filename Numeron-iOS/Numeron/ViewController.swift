//
//  ViewController.swift
//  Numeron
//
//  Created by Wang Shuwei on 2018/5/12.
//  Copyright © 2018 Codingpotato. All rights reserved.
//

import CoreML
import UIKit

private let IMAGE_SIZE = 28

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var canvasView: CanvasView!
    
    private let model = MNISTModel()
    
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
        
        let array = try! MLMultiArray(shape: [1, NSNumber(value: IMAGE_SIZE), NSNumber(value: IMAGE_SIZE)], dataType: .double)
        for row in 0..<IMAGE_SIZE {
            for col in 0..<IMAGE_SIZE {
                array[[0, NSNumber(value: row), NSNumber(value: col)]] = NSNumber(value: data[row * IMAGE_SIZE + col])
            }
        }
        
        let result = try! model.prediction(net__input__0: array)
        return result.eval__result_alt__0[0].intValue
    }
    
}

