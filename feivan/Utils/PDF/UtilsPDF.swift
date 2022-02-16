//
//  Utils.swift
//  Feivan
//
//  Created by javigo on 16/12/21.
//

import Foundation
import SwiftUI


func getDocumentsDirectory() -> NSString {
    /// Get the current directory
    ///
    /// - Returns: the Current directory in NSURL
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory = paths[0]
    return documentsDirectory as NSString
}

extension Data {
    /// Data into file
    ///
    /// - Parameters:
    ///   - fileName: the Name of the file you want to write
    /// - Returns: Returns the URL where the new file is located in NSURL
    func dataToFile(fileName: String) -> NSURL? {

        // Make a constant from the data
        let data = self

        // Make the file path (with the filename) where the file will be loacated after it is created
        let filePath = getDocumentsDirectory().appendingPathComponent(fileName)

        do {
            // Write the file from data into the filepath (if there will be an error, the code jumps to the catch block below)
            try data.write(to: URL(fileURLWithPath: filePath))

            // Returns the URL where the new file is located in NSURL
            return NSURL(fileURLWithPath: filePath)

        } catch {
            // Prints the localized description of the error from the do block
            print("Error writing the file: \(error.localizedDescription)")
        }

        // Returns nil if there was an error in the do-catch -block
        return nil

    }

}

class PDFData {
    var project: ProjectViewModel
    var margin: Double = 50
    var padding: Double = 30
    var half_padding: Double
    var paragraph_style: NSMutableParagraphStyle
    var font_size: Double = 11
    var text_attributes: [NSAttributedString.Key: NSObject]
    
    init(project: ProjectViewModel){
        self.project = project
        self.half_padding = padding/2
        
        let textFont = UIFont.systemFont(ofSize: 11.0, weight: .regular)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .natural
        paragraphStyle.lineBreakMode = .byWordWrapping
        self.paragraph_style = paragraphStyle
        
        self.text_attributes = [
            NSAttributedString.Key.paragraphStyle: paragraphStyle,
            NSAttributedString.Key.font: textFont
        ]
        
       
    }
}

extension String {
    func height(constrainedBy width: CGFloat, with font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return Double(boundingBox.height)
    }

    func width(constrainedBy height: CGFloat, with font: UIFont) -> CGFloat {
        let constrainedRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constrainedRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return Double(boundingBox.width)
    }
}

func getTextFont(string: String, font: Double, weight: UIFont.Weight = .regular, width: Double, height: Double) -> Double {
    var fontSize = font
    
    var textSizeWidth = string.width(constrainedBy: height, with: UIFont.systemFont(ofSize: fontSize, weight: weight))
    while textSizeWidth > width {
        fontSize -= 0.2
        textSizeWidth = string.width(constrainedBy: height, with: UIFont.systemFont(ofSize: fontSize, weight: weight))
    }
    
    var textSizeHeight = string.height(constrainedBy: width, with: UIFont.systemFont(ofSize: fontSize, weight: weight))
    while textSizeHeight > height {
        fontSize -= 0.2
        textSizeHeight = string.height(constrainedBy: width, with: UIFont.systemFont(ofSize: fontSize, weight: weight))
    }

    return fontSize
}
