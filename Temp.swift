//
//  Temp.swift
//  StickerDemo
//
//  Created by P21-0012 on 09/05/22.
//

import UIKit

class SavedData: NSObject {
    
    static let shared = SavedData()
    
    var arrSavedSticker: [SavedSticker] = []
    
    override init() {
        super.init()
    }
}
