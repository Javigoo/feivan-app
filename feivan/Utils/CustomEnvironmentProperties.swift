//
//  CustomEnvironmentProperties.swift
//  Feivan
//
//  Created by javigo on 18/11/21.
//

import Foundation
import SwiftUI

struct RootPresentationKey: EnvironmentKey {
    static let defaultValue: Binding<Bool> = .constant(false)
}

extension EnvironmentValues {
    var rootPresentation: Binding<Bool> {
        get {
            self[RootPresentationKey.self]
        }
        
        set {
            self[RootPresentationKey.self] = newValue
        }
    }
}
