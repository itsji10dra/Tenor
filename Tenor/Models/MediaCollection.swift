//
//  MediaCollection.swift
//  Tenor
//
//  Created by Jitendra on 27/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import Foundation

struct MediaCollection: Decodable {

    let nanoMP4: Media?
    
    let nanoWebM: Media?

    let tinyGIF: Media?
    
    let tinyMP4: Media?

    let tinyWebM: Media?
    
    let webM: Media?

    let gif: Media?

    let mp4: Media?

    let loopedMP4: Media?

    let mediumGIF: Media?

    let nanoGIF: Media?

    enum CodingKeys: String, CodingKey {
        case nanoMP4 = "nanomp4"
        case nanoWebM = "nanowebm"
        case tinyGIF = "tinygif"
        case tinyMP4 = "tinymp4"
        case tinyWebM = "tinywebm"
        case webM = "webm"
        case gif
        case mp4
        case loopedMP4 = "loopedmp4"
        case mediumGIF = "mediumgif"
        case nanoGIF = "nanogif"
    }
}
