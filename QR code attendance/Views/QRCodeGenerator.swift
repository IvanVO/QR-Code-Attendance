//
//  QRCodeGenerator.swift
//  QR code attendance
//
//  Created by Ivan Villanueva on 13/07/21.
//

import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let url: String
    
    var body: some View {
        
        Image(uiImage: generateQRCodeImage(url))
            .interpolation(.none)
            .resizable()
            .frame(width: 150, height: 150, alignment: .center)
    }
    
    func generateQRCodeImage(_ url: String) -> UIImage {
        let data = Data(url.utf8)
        
        filter.setValue(data, forKey: "inputMessage")
        
        if let qrCodeImage = filter.outputImage {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
                
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
