//
//  ImageSaverService.swift
//  marketing-app
//
//  Created by eric collom on 3/1/23.
//

import UIKit

class ImageSaverService: NSObject {
    
    var successHandler: (() -> Void)?
    var errorHandler: ((Error?) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc
    func saveCompleted(_ image: UIImage,
                       didFinishSavingWithError error: Error?,
                       contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
