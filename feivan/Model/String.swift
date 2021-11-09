//
//  String.swift
//  Feivan
//
//  Created by javigo on 5/11/21.
//

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}
