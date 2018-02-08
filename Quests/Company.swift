//
//  Company.swift
//  Quests
//
//  Created by Dmitry Valov on 09.01.2018.
//  Copyright © 2018 Ivan Akulov. All rights reserved.
//

import UIKit

class Company {
    
    var name:String
    var address:String
    var phone:String
    var site:String
    var vk:String
    var email:String
    var icon:String
    var quests:Array<Quest>

    init() {
        self.name = ""
        self.address = ""
        self.phone = ""
        self.site = ""
        self.vk = ""
        self.email = ""
        self.icon = ""
        self.quests = []
    }
    
    init(name:String, address:String, phone:String, site:String, vk:String, email:String, icon:String) {
        self.name = name
        self.address = address
        self.phone = phone
        self.site = site
        self.vk = vk
        self.email = email
        self.icon = icon
        self.quests = []
    }
    
    func addQuest(quest:Quest) {
        self.quests.append(quest)
    }
}
