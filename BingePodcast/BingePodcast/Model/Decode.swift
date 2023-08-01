//
//  Decode.swift
//  BingePodcast
//
//  Created by charlesCalvignac on 31/07/2023.
//

import Foundation

public struct Author {
    let image: String?
    let name: String?
}

public struct Podcast {
    let title: String?
    let image: String?
    let author: String?
}

public struct Episode {
    let title: String?
    let subtitle: String?
    let description: String?
    let totalTime: String?
    let imageUrl: String?
    let playerUrl: String?
}
