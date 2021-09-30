//
//  textStyles.swift
//  feivan
//
//  Created by javigo on 28/9/21.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .lineSpacing(8)
            .foregroundColor(.primary)
    }
}

struct NavigationLinkStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 250, height: 20, alignment: .center)
            .foregroundColor(.black)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
