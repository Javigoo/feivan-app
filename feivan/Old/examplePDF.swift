//
//  examplePDF.swift
//  Feivan
//
//  Created by javigo on 12/12/21.
//

import Foundation
import SwiftUI

func addTitle(pageRect: CGRect) -> CGFloat {
  let title: String = "Title"
  // 1
  let titleFont = UIFont.systemFont(ofSize: 18.0, weight: .bold)
  // 2
  let titleAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: titleFont]
  let attributedTitle = NSAttributedString(string: title, attributes: titleAttributes)
  // 3
  let titleStringSize = attributedTitle.size()
  // 4
  let titleStringRect = CGRect(x: (pageRect.width - titleStringSize.width) / 2.0,
                               y: 36, width: titleStringSize.width,
                               height: titleStringSize.height)
  // 5
  attributedTitle.draw(in: titleStringRect)
  // 6
  return titleStringRect.origin.y + titleStringRect.size.height
}

func addBodyText(pageRect: CGRect, textTop: CGFloat) {
  // 1
  let textFont = UIFont.systemFont(ofSize: 12.0, weight: .regular)
  // 2
  let paragraphStyle = NSMutableParagraphStyle()
  paragraphStyle.alignment = .natural
  paragraphStyle.lineBreakMode = .byWordWrapping
  // 3
  let textAttributes = [
    NSAttributedString.Key.paragraphStyle: paragraphStyle,
    NSAttributedString.Key.font: textFont
  ]
  let body: String = "body"
  let attributedText = NSAttributedString(string: body, attributes: textAttributes)
  // 4
  let textRect = CGRect(x: 10, y: textTop, width: pageRect.width - 20,
                        height: pageRect.height - textTop - pageRect.height / 5.0)
  attributedText.draw(in: textRect)
}

func addImage(pageRect: CGRect, imageTop: CGFloat) -> CGFloat {
  let image: UIImage = UIImage(systemName: "photo")!
  // 1
  let maxHeight = pageRect.height * 0.4
  let maxWidth = pageRect.width * 0.8
  // 2
  let aspectWidth = maxWidth / image.size.width
  let aspectHeight = maxHeight / image.size.height
  let aspectRatio = min(aspectWidth, aspectHeight)
  // 3
  let scaledWidth = image.size.width * aspectRatio
  let scaledHeight = image.size.height * aspectRatio
  // 4
  let imageX = (pageRect.width - scaledWidth) / 2.0
  let imageRect = CGRect(x: imageX, y: imageTop,
                         width: scaledWidth, height: scaledHeight)
  // 5
  image.draw(in: imageRect)
  return imageRect.origin.y + imageRect.size.height
}

// 1
func drawTearOffs(_ drawContext: CGContext, pageRect: CGRect,
                  tearOffY: CGFloat, numberTabs: Int) {
  // 2
  drawContext.saveGState()
  drawContext.setLineWidth(2.0)
  
  // 3
  drawContext.move(to: CGPoint(x: 0, y: tearOffY))
  drawContext.addLine(to: CGPoint(x: pageRect.width, y: tearOffY))
  drawContext.strokePath()
  drawContext.restoreGState()
  
  // 4
  drawContext.saveGState()
  let dashLength = CGFloat(72.0 * 0.2)
  drawContext.setLineDash(phase: 0, lengths: [dashLength, dashLength])
  // 5
  let tabWidth = pageRect.width / CGFloat(numberTabs)
  for tearOffIndex in 1..<numberTabs {
    // 6
    let tabX = CGFloat(tearOffIndex) * tabWidth
    drawContext.move(to: CGPoint(x: tabX, y: tearOffY))
    drawContext.addLine(to: CGPoint(x: tabX, y: pageRect.height))
    drawContext.strokePath()
  }
  // 7
  drawContext.restoreGState()
}

func drawContactLabels(_ drawContext: CGContext, pageRect: CGRect, numberTabs: Int) {
  let contactInfo: String = "contactInfo"
  let contactTextFont = UIFont.systemFont(ofSize: 10.0, weight: .regular)
  let paragraphStyle = NSMutableParagraphStyle()
  paragraphStyle.alignment = .natural
  paragraphStyle.lineBreakMode = .byWordWrapping
  let contactBlurbAttributes = [
    NSAttributedString.Key.paragraphStyle: paragraphStyle,
    NSAttributedString.Key.font: contactTextFont
  ]
  let attributedContactText = NSMutableAttributedString(string: contactInfo, attributes: contactBlurbAttributes)
  // 1
  let textHeight = attributedContactText.size().height
  let tabWidth = pageRect.width / CGFloat(numberTabs)
  let horizontalOffset = (tabWidth - textHeight) / 2.0
  drawContext.saveGState()
  // 2
  drawContext.rotate(by: -90.0 * CGFloat.pi / 180.0)
  for tearOffIndex in 0...numberTabs {
    let tabX = CGFloat(tearOffIndex) * tabWidth + horizontalOffset
    // 3
    attributedContactText.draw(at: CGPoint(x: -pageRect.height + 5.0, y: tabX))
  }
  drawContext.restoreGState()
}
