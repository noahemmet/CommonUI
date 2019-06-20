//
//  ListController.swift
//  CommonUI
//
//  Created by Noah Emmet on 6/24/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import Foundation

// Controllers

/// Represents a top-level controller of lists.
public protocol ListControlling {
    var sectionControllers: [SectionControlling] { get }
}

/// A `UICollectionViewDataSource`, generic over a `ListControlling`.
public class CollectionListDataSource<ListController: ListControlling>: NSObject, UICollectionViewDataSource {
    public var listController: ListController
    public var drawBorders: Bool = true
    
    public init(listController: ListController, collectionView: UICollectionView) {
        self.listController = listController
        self.listController.registerCells(in: collectionView)
        super.init()
    }

    public init(listController: ListController) {
        self.listController = listController
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listController.sectionControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionController = listController.sectionControllers[section]
        return sectionController.itemControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionController = listController.sectionControllers[indexPath.section]
        let itemController = sectionController.itemControllers[indexPath.row]
        let cell = itemController.cell(at: indexPath, in: collectionView)
        return cell
    }
}

public protocol SectionControlling {
    var itemControllers: [ItemControlling] { get }
}

public protocol ItemControlling {
    func registerCell(in collectionView: UICollectionView)
    func cell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell
}

// MARK: - Protocol Extensions

public extension ListControlling {
    func registerCells(in collectionView: UICollectionView) {
        let allItemControllers = sectionControllers.flatMap { $0.itemControllers}
        for itemController in allItemControllers {
            itemController.registerCell(in: collectionView)
        }
    }
    
//    func registerCells<View: UIView & ViewModelConfigurable>(wrappingTypes viewTypes: [View.Type], in collectionView: UICollectionView) {
//        print("generic viewTypes.count: ", viewTypes.count)
//        for viewType in viewTypes {
//            collectionView.registerCell(wrapping: viewType)
//        }
//    }
}

// MARK: - DefaultControllers

public struct SingleTypeSectionController<View: UIView & ViewModelConfigurable>: SectionControlling {
    public var itemControllers: [ItemControlling]

    public init<ViewModel>(items: [ViewModel], viewType: View.Type, drawBorders: Bool = true) where ViewModel == View.ViewModel {
        self.itemControllers = items.map { DefaultItemController<View>.init(item: $0, viewType: viewType, drawBorders: drawBorders) }
    }
}

public struct DefaultItemController<View: UIView & ViewModelConfigurable>: ItemControlling {
    public typealias Configuration = (View.ViewModel, View, WrapperCollectionCell<View>, UICollectionView, IndexPath) -> Void
    public let item: View.ViewModel
    public var configure: Configuration?
    public var drawBorders: Bool
    public var isSelectable: Bool

    public init(item: View.ViewModel, 
                viewType: View.Type, 
                drawBorders: Bool = true,
                isSelectable: Bool = true,
                configure: Configuration? = nil) {
        self.item = item
        self.drawBorders = drawBorders
        self.isSelectable = isSelectable
        self.configure = configure
    }
    
    public func registerCell(in collectionView: UICollectionView) {
        collectionView.registerCell(wrapping: View.self)
    }
    
    public func cell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(wrapping: View.self, at: indexPath)
        // Use the custom configuration handler, or automatically configure the cell.
        if let configure = configure {
            configure(item, cell.wrappedView, cell, collectionView, indexPath)
        } else {
            cell.configure(with: item)
            if drawBorders {
                cell.configureBorders(at: indexPath, in: collectionView)
            }
            cell.isSelectable = isSelectable
        }
        return cell
    }
}

// MARK: - DefaultListViewController

public class DefaultListViewController<ListController: ListControlling>: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, ViewModelConfigurable {
    public static func defaultFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.itemSize = CGSize(width: 320, height: 100)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        return flowLayout
    }
    
    public var listController: ListController
    public let collectionView: UICollectionView
    
    public init(listController: ListController, 
                collectionViewLayout: UICollectionViewLayout = DefaultListViewController.defaultFlowLayout()) {
        self.listController = listController
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        super.init(nibName: nil, bundle: nil)
        listController.registerCells(in: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        configure(with: listController)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with listController: ListController) {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return listController.sectionControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionController = listController.sectionControllers[section]
        return sectionController.itemControllers.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionController = listController.sectionControllers[indexPath.section]
        let itemController = sectionController.itemControllers[indexPath.row]
        let cell = itemController.cell(at: indexPath, in: collectionView)
        print(cell)
        return cell
    }
}
