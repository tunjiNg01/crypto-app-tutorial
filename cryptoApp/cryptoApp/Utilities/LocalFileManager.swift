//
//  LocalFileManager.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 14/08/2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    static let instance = LocalFileManager()
    
    private init() {}
    
    func saveImage(image: UIImage, folderName: String, imageName: String) {
        
        // create folder if needed
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(),
              let url =  getImageUrl(imageName: imageName, folderName: folderName)
        else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving Image: \(error)")
        }
    }
    
    func getImage(folderName: String, imageName: String) -> UIImage?{
        guard let url = getImageUrl(imageName: imageName, folderName: folderName), FileManager.default.fileExists(atPath: url.path()) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
    private func createFolderIfNeeded(folderName: String){
        guard let url = getUrlForFolder(folderName: folderName) else {
            return
        }
        if !FileManager.default.fileExists(atPath: url.path()){
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                print("Error creating folder: \(folderName), \(error)")
            }
        }
    }
    
    private func getUrlForFolder(folderName: String) -> URL?{
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getImageUrl(imageName: String, folderName: String) -> URL? {
        guard let folderUrl = getUrlForFolder(folderName: folderName) else {
            return nil
        }
        
        return folderUrl.appendingPathComponent(imageName + ".png")
    }
}
