//
//  Alert.Item.swift
//  Castbox
//
//  Created by lazy on 2018/7/12.
//  Copyright © 2018年 Guru. All rights reserved.
//

import Foundation

extension _Alert {
    
    public typealias Action = (_ title: String)->()
    
    open class Item {
        
        public var icon: UIImage?
        public var title: String = ""
        public var handler: Action?
        
        public init(icon: UIImage?, title: String, handler: Action?) {
            self.icon = icon
            self.title = title
            self.handler = handler
        }
        
        public init() {
            
        }
    }
}
