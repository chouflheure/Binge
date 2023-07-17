//
//  PagesFavoriteScreen.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 17/07/2023.
//

import Foundation

enum PagesFavoriteScreen: CaseIterable {
    case pageZero
    case pageOne
    
    var index: Int {
        switch self {
        case .pageZero:
            return 0
        case .pageOne:
            return 1
  
        }
    }
}
