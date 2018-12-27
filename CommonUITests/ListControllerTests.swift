//
//  ListControllerTests.swift
//  CommonUITests
//
//  Created by Noah Emmet on 6/25/18.
//  Copyright © 2018 Sticks. All rights reserved.
//

import XCTest
import CommonUI

class ListControllerTest: XCTestCase {
    
    // ItemViewModels
    
    struct HeaderViewModel {
        var headerText: String
    }
    
    struct TextViewModel {
        var text: String
    }
    
    struct ImageViewModel {
        var image: UIImage?
    }
    
    // SectionViewModels
    
    struct PostViewModel {
        var headerViewModel: HeaderViewModel?
        var textViewModels: [TextViewModel]
    }
    
    struct PhotoPostViewModel {
        var imageViewModel: ImageViewModel
        var textViewModels: [TextViewModel]
    }
    
    // ListViewModel
    
    struct TimelineViewModel {
        var postViewModels: [PostViewModel]
        var photoPostViewModels: [PhotoPostViewModel]
    }
    
    // ItemViews
    
    class HeaderView: UILabel, ViewModelConfigurable {
        func configure(with viewModel: HeaderViewModel) {
            self.text = viewModel.headerText
        }
    }
    
    class TextView: UILabel, ViewModelConfigurable {
        func configure(with viewModel: TextViewModel) {
            self.text = viewModel.text
        }
    }
    
    class ImageView: UIImageView, ViewModelConfigurable {
        func configure(with viewModel: ImageViewModel) {
            self.image = viewModel.image
        }
    }
    
    // ItemControllers
    
    struct HeaderItemController: ItemControlling {
        var viewModel: HeaderViewModel
        func registerCell(in collectionView: UICollectionView) {
            collectionView.registerCell(wrapping: HeaderView.self)
        }
        
        func cell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
            let cell = collectionView.dequeueCell(wrapping: HeaderView.self, at: indexPath)
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    struct TextItemController: ItemControlling {
        var viewModel: TextViewModel
        
        func registerCell(in collectionView: UICollectionView) {
            collectionView.registerCell(wrapping: TextView.self)
        }
        
        func cell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
            let cell = collectionView.dequeueCell(wrapping: TextView.self, at: indexPath)
            cell.configure(with: viewModel)
            return cell
        }
    }
    
    // Sections
    
    struct PostSection: SectionControlling {
        var headerViewModel: HeaderViewModel?
        var textViewModels: [TextViewModel]
        var itemControllers: [ItemControlling] {
            var itemControllers: [ItemControlling] = textViewModels.map { TextItemController(viewModel: $0) }
            if let headerViewModel = headerViewModel {
                itemControllers.append(HeaderItemController(viewModel: headerViewModel))
            }
            return itemControllers
        }
        
        init(headerViewModel: HeaderViewModel?, textViewModels: [TextViewModel]) {
            self.headerViewModel = headerViewModel
            self.textViewModels = textViewModels
        }
    }
    
    struct PhotoPostSection: SectionControlling {
        var imageViewModel: ImageViewModel
        var textViewModels: [TextViewModel]
        var itemControllers: [ItemControlling] {
            var itemControllers: [ItemControlling] = textViewModels.map { TextItemController(viewModel: $0) }
            itemControllers.append(DefaultItemController(item: imageViewModel, viewType: ImageView.self))
            return itemControllers
        }
    }
    
    // ListController
    
    class TimelineListController: ListControlling {
        
        var sectionControllers: [SectionControlling]
        init(viewModel: TimelineViewModel) {
            let postSections: [SectionControlling] = viewModel.postViewModels.map { PostSection(headerViewModel: $0.headerViewModel, textViewModels: $0.textViewModels) }
            let photoPostSections: [SectionControlling] = viewModel.photoPostViewModels.map { PhotoPostSection(imageViewModel: $0.imageViewModel, textViewModels: $0.textViewModels) }
            self.sectionControllers = postSections + photoPostSections
        }
    }
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListController() {

        let headerViewModel1 = HeaderViewModel(headerText: "HeaderViewModel")
        let textViewModel1 = TextViewModel(text: "TextViewModel 1")
        let textViewModel2 = TextViewModel(text: "TextViewModel 2")
        let textViewModel3 = TextViewModel(text: "TextViewModel 3")
        let postViewModel = PostViewModel(headerViewModel: headerViewModel1, textViewModels: [textViewModel1, textViewModel2])
        let imageViewModel = ImageViewModel(image: nil)
        let photoPostViewModel = PhotoPostViewModel(imageViewModel: imageViewModel, textViewModels: [textViewModel1, textViewModel3])
        let timelineViewModel = TimelineViewModel(postViewModels: [postViewModel], photoPostViewModels: [photoPostViewModel])
        let timelineListController = TimelineListController(viewModel: timelineViewModel)
        
        let defaultListViewController = DefaultListViewController(listController: timelineListController)
        let collectionView = defaultListViewController.collectionView
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        XCTAssertTrue(collectionView.frame.size.width > 0)
        XCTAssertTrue(collectionView.frame.size.height > 0)
        XCTAssertEqual(collectionView.numberOfSections, 2)
        XCTAssertEqual(collectionView.numberOfItems(inSection: 0), 3)
        let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 1))
        XCTAssertNotNil(cell)
        print(defaultListViewController.view)
    }
}
