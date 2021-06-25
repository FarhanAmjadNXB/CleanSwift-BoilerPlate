//
//  Array+Utils.swift

import Vision
import Foundation


extension Array {
  func penultimate() -> Element? {
      if self.count < 2 {
          return nil
      }
      let index = self.count - 2
      return self[index]
  }
}
