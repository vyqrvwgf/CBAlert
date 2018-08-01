//
//  Alert+Table.swift
//  CBAlert
//
//  Created by 韩磊 on 2018/8/1.
//

import Foundation

class _Table: NSObject, Content, UITableViewDataSource, UITableViewDelegate {
    
    fileprivate static let itemHeight: CGFloat = 50.0
    
    // MARK: - Private
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ListCell.self, forCellReuseIdentifier: NSStringFromClass(ListCell.self))
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private var items: [_Alert.Item] = [_Alert.Item]()
    private var map = [String: CGFloat]()
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        tableView.rowHeight = _Table.itemHeight
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ListCell.self), for: indexPath) as! ListCell
        cell.config(title: items[indexPath.row].title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let title = items[indexPath.row].title
        if let heightCache = map[title], heightCache > 0 {
            return heightCache
        } else {
            let height = title.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 30.0, height: CGFloat(MAXFLOAT)),
                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                            attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)],
                                            context: nil).height + 30.0
            map[title] = height
            return height
        }
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        dismiss()
        items[indexPath.row].handler?(items[indexPath.row].title)
    }
    
    // MARK: - Content
    var dismiss: () -> () = {}
    
    func view() -> UIView {
        return tableView
    }
    
    func frame() -> CGRect {
        return tableView.frame
    }
    
    func set(with items: [_Alert.Item]) {
        self.items = items
        let totoalHeight = items.map { (item) -> CGFloat in
            if let heightCache = map[item.title], heightCache > 0 {
                return heightCache
            } else {
                let height = item.title.boundingRect(with: CGSize(width: UIScreen.main.bounds.width - 30.0, height: CGFloat(MAXFLOAT)),
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17.0)],
                                                     context: nil).height + 30.0
                map[item.title] = height
                return height
            }
            }.reduce(0.0, { $0 + $1 })
        tableView.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: totoalHeight)
        tableView.reloadData()
    }
}

class ListCell: UITableViewCell {
    
    // MARK: - Internal
    func config(title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Private
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let separator: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    // MARK: - Life Cycle
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(separator)
        
        titleLabel.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: _Table.itemHeight)
        separator.frame = CGRect(x: 0.0, y: titleLabel.frame.maxY - 0.5, width: UIScreen.main.bounds.width, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
