//
//  Alert.Item.swift
//  Castbox
//
//  Created by lazy on 2018/7/12.
//  Copyright © 2018年 Guru. All rights reserved.
//

import Foundation

extension Alert {
    
    typealias Action = ()->()
    
    struct Item {
        
        var icon: UIImage?
        var title: String = ""
        var handler: Action?
        
        init(icon: UIImage?, title: String, handler: Action?) {
            self.icon = icon
            self.title = title
            self.handler = handler
        }
        
        init() {
            
        }
    }
}
