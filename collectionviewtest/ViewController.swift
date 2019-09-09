//
//  ViewController.swift
//  collectionviewtest
//
//  Created by Joao Duarte on 04/09/19.
//  Copyright © 2019 FullArm Mobile. All rights reserved.
//

import UIKit
import MSPeekCollectionViewDelegateImplementation

class ViewController: UIViewController{
    
    weak var collectionView: UICollectionView!
    let delegate = MSPeekCollectionViewDelegateImplementation()

    var data: [Int] = Array(0..<10)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = .gray
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        
        let statusBarSize = UIApplication.shared.statusBarFrame.size.height
        var sizeNavBar: CGFloat = 0.0
        
        if let nav = self.navigationController {
            nav.navigationBar.topItem?.title = "Example Collection Horizontal"
            sizeNavBar = nav.navigationBar.frame.size.height
        }

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: statusBarSize + sizeNavBar + 10),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: self.view.bounds.height*0.35)
        ])
        
        self.collectionView = collectionView
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = delegate
        self.collectionView.configureForPeekingDelegate()

        self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
        self.collectionView.backgroundColor = .clear
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        cell.layer.cornerRadius = 10
        let data = self.data[indexPath.item]
        cell.textLabel.text = String(data)
        cell.backgroundColor = .white
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
class Cell: UICollectionViewCell {
    
    static var identifier: String = "Cell"
    
    weak var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let textLabel = UILabel(frame: .zero)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            self.contentView.centerXAnchor.constraint(equalTo: textLabel.centerXAnchor),
            self.contentView.centerYAnchor.constraint(equalTo: textLabel.centerYAnchor),
            ])
        self.textLabel = textLabel
        self.reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.reset()
    }
    
    func reset() {
        self.textLabel.textAlignment = .center
    }
}
