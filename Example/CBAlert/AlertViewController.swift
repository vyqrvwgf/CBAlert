//
//  AlertViewController.swift
//  CBAlert_Example
//
//  Created by 韩磊 on 2018/7/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import CBAlert

class AlertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "more", style: .plain, target: self, action: #selector(onTapMore))
        
        alert.set(with: [1, 2, 3, 4, 5]
            .map({
                _Alert.Item(icon: nil, title: "\($0)", handler: { (title) in
                    print(title)
                })
            }))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    let alert = _Alert.alert(with: .collection)
    
    // MARK: - Custom Method
    @objc private func onTapMore() {
        
        alert.show()
    }
}

class CancelItem: NSObject, Cancel {
    
    private lazy var subview: UIView = {
        let view = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 44.0))
        view.backgroundColor = .green
        return view
    }()
    
    func view() -> UIView {
        return subview
    }
    
    func frame() -> CGRect {
        return subview.frame
    }
    
    var dismiss: () -> () = { }
}

class ContentItem: NSObject, Content {
    
    private lazy var subview: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .yellow
        return view
    }()
    
    func set(with items: [_Alert.Item]) {
        subview.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: CGFloat(items.count)*50.0)
    }
    
    func view() -> UIView {
        return subview
    }
    
    func frame() -> CGRect {
        return subview.frame
    }
    
    var dismiss: () -> () = { }
}
