//
//  Alert.UI.swift
//  Castbox
//
//  Created by lazy on 2018/7/12.
//  Copyright © 2018年 Guru. All rights reserved.
//

import Foundation

extension _Alert {
    
    enum State {
        case show
        case dismiss
    }
    
    class Cover: UIView {
        
        public var dismiss: (()->())?
        
        internal var state: State = .dismiss {
            didSet {
                switch state {
                case .show:
                    self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.4)
                case .dismiss:
                    self.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
                }
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            
            backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTapDismiss))
            addGestureRecognizer(tap)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        @objc private func onTapDismiss() {
            dismiss?()
        }
        
        deinit {
            print("Cover deinit")
        }
    }
    
    class Container: UIView {
        
        private let kScreenWidth: CGFloat = UIScreen.main.bounds.width
        private let kScreenHeight: CGFloat = UIScreen.main.bounds.height

        private var totoalHeight: CGFloat = 0.0
        
        // MARK: - Internal
        internal var state: State = .dismiss {
            didSet {
                switch state {
                case .show:
                    self.frame = CGRect(x: 0.0, y: kScreenHeight - totoalHeight, width: kScreenWidth, height: totoalHeight)
                case .dismiss:
                    self.frame = CGRect(x: 0.0, y: kScreenHeight, width: kScreenWidth, height: totoalHeight)
                }
            }
        }
        
        internal func set(content: Content, cancel: Cancel?) {
            
            let _content = content.view()
            totoalHeight = content.frame().height
            _content.frame = CGRect(x: 0.0, y: 0.0, width: _content.bounds.width, height: totoalHeight)
            
            addSubview(_content)
            
            if let cancel = cancel {
                let _cancel = cancel.view()
                _cancel.frame = CGRect(x: 0.0, y: _content.frame.maxY, width: _cancel.bounds.width, height: _cancel.bounds.height)
                
                totoalHeight += cancel.frame().height
                addSubview(_cancel)
            }
            
            self.state = .dismiss
        }
        
        // MARK: - Life Cycle
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//
//            let maskPath = UIBezierPath(roundedRect: self.bounds,
//                                        byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight],
//                                        cornerRadii: CGSize(width: 5.0, height: 5.0))
//
//            let maskLayer = CAShapeLayer()
//            maskLayer.frame = self.bounds
//            maskLayer.path = maskPath.cgPath
//
//            layer.mask = maskLayer
//        }
//
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
        
        deinit {
            print("Container deinit")
        }
    }
}
