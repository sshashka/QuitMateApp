//
//  String+Extension.swift
//  QuitMate
//
//  Created by Саша Василенко on 02.08.2023.
//

import Foundation

extension String {
  func localize() -> String {
    return NSLocalizedString(
      self,
      tableName: "Localizable",
      bundle: .main,
      value: self,
      comment: self)
  }
   
  public func localize(with arguments: [CVarArg]) -> String {
    return String(format: self.localize(), locale: nil, arguments: arguments)
  }
}
