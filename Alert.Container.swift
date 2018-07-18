//
//  Alert.UI.swift
//  Castbox
//
//  Created by lazy on 2018/7/12.
//  Copyright © 2018年 Guru. All rights reserved.
//

import Foundation
import RxSwift

extension Alert {
    
    enum State {
        case show
        case dismiss
    }
    
    class Cover: UIView {
        
        public var dismiss: (()->())?
        
        var state: State = .dismiss {
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
    }
    
    class Container: UIView {
        
        public var dismiss: (()->())?
        
        // MARK: - Const
        private let itemHeight: CGFloat = 50.0
        private let cancelHeight: CGFloat = {
            if let window = UIApplication.shared.keyWindow, #available(iOS 11.0, *) {
                return 49.0 + window.safeAreaInsets.bottom
            } else {
                return UIScreen.main.bounds.height == 812.0 ? 81.0 : 49.0
            }
        }()
        
        private let kScreenWidth: CGFloat = UIScreen.main.bounds.width
        private let kScreenHeight: CGFloat = UIScreen.main.bounds.height
        
        private var totoalHeight: CGFloat = 0.0
        
        // MARK: - Internal
        var state: State = .dismiss {
            didSet {
                switch state {
                case .show:
                    self.frame = CGRect(x: 0.0, y: kScreenHeight - totoalHeight, width: kScreenWidth, height: totoalHeight)
                case .dismiss:
                    self.frame = CGRect(x: 0.0, y: kScreenHeight, width: kScreenWidth, height: totoalHeight)
                }
            }
        }
        
        // MARK: - Private
        private let cancelButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
            button.addTarget(self, action: #selector(onTapCancel), for: .touchUpInside)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
            let safeAreaHeight: CGFloat
            if #available(iOS 11.0, *) {
                safeAreaHeight = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0.0
            } else {
                safeAreaHeight = 32.0
            }
            button.titleEdgeInsets = UIEdgeInsetsMake(-safeAreaHeight*0.5, 0.0, safeAreaHeight*0.5, 0.0)
            return button
        }()
        
        private let separator: UIView = {
            let view = UIView(frame: .zero)
            return view
        }()
        
        private let disposeBag = DisposeBag()
        
        // MARK: - Life Cycle
        convenience init(subview: Subview) {
            self.init(frame: .zero)
            
            let view = subview.view()
            let frame = subview.frame()
            view.frame = frame
            
            totoalHeight = frame.height + cancelHeight
            addSubview(view)
            
            rx.backgroundColor.setTheme(by: .contentWhite).disposed(by: disposeBag)
            cancelButton.rx.backgroundColor.setTheme(by: .backgroundWhite).disposed(by: disposeBag)
            cancelButton.rx.titleColor().setTheme(by: .textBlack).disposed(by: disposeBag)
            separator.rx.backgroundColor.setTheme(by: .lineWhite).disposed(by: disposeBag)
            
            addSubview(separator)
            addSubview(cancelButton)
            
            self.frame = CGRect(x: 0.0, y: kScreenHeight, width: kScreenWidth, height: totoalHeight)
            cancelButton.frame = CGRect(x: 0.0, y: bounds.height - cancelHeight, width: kScreenWidth, height: cancelHeight)
            separator.frame = CGRect(x: 0.0, y: 0.0, width: kScreenWidth, height: SeparatorLine.lineHeight)
            
            // set corner
            let maskPath = UIBezierPath(roundedRect: self.bounds,
                                        byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight],
                                        cornerRadii: CGSize(width: 5.0, height: 5.0))
            
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = maskPath.cgPath
            
            layer.mask = maskLayer
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Event
        @objc private func onTapCancel() {
            dismiss?()
        }
    }
}
