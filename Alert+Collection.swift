//
//  Alert+Collection.swift
//  CBAlert
//
//  Created by 韩磊 on 2018/8/1.
//

import Foundation

class _Collection: NSObject, Content, UICollectionViewDataSource, UICollectionViewDelegate {
    
    // MARK: - Private
    private var items: [_Alert.Item] = [_Alert.Item]()
    
    private let flowLayout = FlowLayout()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: FlowLayout())
        collectionView.register(FlowLayoutCell.self, forCellWithReuseIdentifier: NSStringFromClass(FlowLayoutCell.self))
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FlowLayoutCell.self), for: indexPath) as! FlowLayoutCell
        let item = items[indexPath.item]
        cell.config(icon: item.icon, title: item.title)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        dismiss()
        items[indexPath.item].handler?(items[indexPath.item].title)
    }
    
    // MARK: - Subview
    var dismiss = { }
    
    func view() -> UIView {
        return collectionView
    }
    
    func frame() -> CGRect {
        return collectionView.frame
    }
    
    func set(with items: [_Alert.Item]) {
        self.items = items
        
        var count: Int = items.count
        var row: Int = 0
        repeat {
            row += 1
            count -= 3
        } while (count > 0)
        
        collectionView.frame = CGRect(x: 0.0,
                                      y: 0.0,
                                      width: UIScreen.main.bounds.width,
                                      height: flowLayout.edge.top + CGFloat(row) * (flowLayout.height + 20.0) + flowLayout.edge.bottom)
        collectionView.reloadData()
    }
}

class FlowLayoutCell: UICollectionViewCell {
    
    // MARK: - Internal
    func config(icon: UIImage?, title: String) {
        iconImageView.image = icon
        titleLabel.text = title
    }
    
    // MARK: - Private
    private let iconImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 13.0)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        iconImageView.frame = CGRect(x: 0.0, y: 0.0, width: contentView.bounds.width, height: contentView.bounds.width)
        titleLabel.frame = CGRect(x: -10.0, y: iconImageView.frame.maxY + 7.0, width: iconImageView.bounds.width+20.0, height: titleLabel.font.lineHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FlowLayout: UICollectionViewLayout {
    
    var offset: CGFloat  {
        return (UIScreen.main.bounds.width - 60.0 * CGFloat(maxHorizontal)) / CGFloat(maxHorizontal + 1)
    }
    var edge: UIEdgeInsets {
        return UIEdgeInsetsMake(30.0, offset, 20.0, offset)
    }
    
    let maxHorizontal: Int = 3
    let width: CGFloat = 60.0
    let height: CGFloat = 82.0
    
    private var attributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        guard let collectionView = self.collectionView else {
            return
        }
        if collectionView.numberOfSections == 0 {
            return
        }
        
        for i in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: i, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let x = i % maxHorizontal
            let y = i / maxHorizontal
            
            attribute.frame = CGRect(x: offset + CGFloat(x) * (offset + width),
                                     y: edge.top + CGFloat(y) * (20.0 + height),
                                     width: width,
                                     height: height)
            
            attributes.append(attribute)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attributes
    }
}
