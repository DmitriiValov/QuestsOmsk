//
//  Quest.swift
//  Quests
//
//  Created by Dmitry Valov on 09.01.2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class Quest {

    var name:String
    var shortName:String
    var capacity:String
    var duration:String
    var complexity:String
    var definition:String
    var link:String
    var images:Array<String>

    init() {
        self.name = ""
        self.shortName = ""
        self.capacity = ""
        self.duration = ""
        self.complexity = ""
        self.definition = ""
        self.link = ""
        self.images = []
    }
    
    init(name:String, shortName:String, capacity:String, duration:String, complexity:String, definition:String, link:String) {
        self.name = name
        self.shortName = shortName
        self.capacity = capacity
        self.duration = duration
        self.complexity = complexity
        self.definition = definition
        self.link = link
        self.images = []
    }
    
    func addImage(image:String) {
        self.images.append(image)
    }
}
