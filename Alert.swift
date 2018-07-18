//
//  Alert.swift
//  Castbox
//
//  Created by lazy on 2018/7/12.
//  Copyright © 2018年 Guru. All rights reserved.
//

import Foundation
import RxSwift

protocol Subview {
    
    var dismiss: ()->() { set get }
    
    func view() -> UIView
    // 提醒设置frame
    func frame() -> CGRect
    
    func set(with items: [Alert.Item])
}

class Alert {
    
    enum Style {
        case list
        case collection
    }
    
    // MARK: - Public
    @discardableResult
    func set(with items: [Alert.Item]) -> Self {
        self.items = items
        return self
    }
    
    @discardableResult
    func add(of item: Alert.Item) -> Self {
        if items.map({ $0.title }).contains(item.title) {
            return self
        } else {
            items.append(item)
            return self
        }
    }
    
    func show() {
        prepare()
        UIView.animate(withDuration: 0.25) {
            self.container.state = .show
            self.cover.state = .show
        }
    }
    
    // MARK: - Private
    private func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.cover.state = .dismiss
            self.container.state = .dismiss
        }) { (finished) in
            if finished {
                self.complete()
            }
        }
    }
    private let disposeBag = DisposeBag()
    
    var items: [Alert.Item] = [Alert.Item]()
    
    private var container: Container = Container()
    private var subview: Subview
    
    private let cover: Cover = {
        let cover = Cover()
        return cover
    }()
    
    private var style: Style = .list
    
    // MARK: - Life Cycle
    init(style: Style) {
        self.style = style
        
        switch style {
        case .list:
            subview = List()
        case .collection:
            subview = Collection()
        }
    }
    
    // MARK: - Custom Method
    private func prepare() {
        subview.set(with: items)
        container = Container(subview: subview)
        
        subview.dismiss = { [weak self] in
            self?.dismiss()
        }
        container.dismiss = { [weak self] in
            self?.dismiss()
        }
        cover.dismiss = { [weak self] in
            self?.dismiss()
        }
        
        let window = UIApplication.shared.keyWindow
        window?.addSubview(cover)
        window?.addSubview(container)
    }
    
    private func complete() {
        cover.removeFromSuperview()
        container.removeFromSuperview()
    }
}
