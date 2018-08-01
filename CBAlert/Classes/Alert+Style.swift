//
//  Alert+Style.swift
//  CBAlert
//
//  Created by 韩磊 on 2018/8/1.
//

import Foundation

extension _Alert {
    
    public enum _Style {
        case table
        case collection
        
        public static var _allCases: [_Style] = [.table, .collection]
    }
    
    public class func alert(with style: _Style) -> _Alert {
        switch style {
        case .table:
            return _Alert(contentClazz: _Table.self, cancelClazz: _Cancel.self)
        case .collection:
            return _Alert(contentClazz: _Collection.self, cancelClazz: _Cancel.self)
        }
    }
}

class _Cancel: NSObject, Cancel {
    
    // MARK: - Private
    private lazy var cancel: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 50.0)
        button.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
    }
    
    // MARK: - Cancel
    var dismiss: () -> () = {}
    
    func view() -> UIView {
        return cancel
    }
    
    func frame() -> CGRect {
        return cancel.frame
    }
}
