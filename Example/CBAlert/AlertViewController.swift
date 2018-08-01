//
//  AlertViewController.swift
//  CBAlert_Example
//
//  Created by 韩磊 on 2018/7/18.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import CBAlert

class AlertViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: self.view.bounds, style: .plain)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _Alert._Style._allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        cell.textLabel?.text = _Alert._Style._allCases
        return cell
    }

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
