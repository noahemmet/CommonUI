import UIKit
import PlaygroundSupport
import CommonUI

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
    self.backgroundColor = .red
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

//struct HeaderItemController: ItemControlling {
//    var viewModel: HeaderViewModel
//    
//    func registerCells(in collectionView: UICollectionView) {
//        print("HeaderItemController.registerCells")
//        collectionView.registerCell(wrapping: HeaderView.self)
//    }
//    
//    func cell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
//        print("HeaderItemController.cellAt")
//        let cell = collectionView.dequeueCell(wrapping: HeaderView.self, at: indexPath)
//        print("cell: ", cell)
//        cell.configure(with: viewModel)
//        return cell
//    }
//}

//struct TextItemController: ItemControlling {
//    var viewModel: TextViewModel
//    
//    func registerCell(in collectionView: UICollectionView) {
//        print("TextItemController.register")
//        collectionView.registerCell(wrapping: TextView.self)
//    }
//    
//    func cell(at indexPath: IndexPath, in collectionView: UICollectionView) -> UICollectionViewCell {
//        let cell = collectionView.dequeueCell(wrapping: TextView.self, at: indexPath)
//        print("cell at indexpath1: ", cell)
//        cell.configure(with: viewModel)
//        print("cell at indexpath2: ", cell.wrappedView)
//        return cell
//    }
//}

// Section Controllers

struct PostSection: SectionControlling {
  var headerViewModel: HeaderViewModel?
  var textViewModels: [TextViewModel]
  var itemControllers: [ItemControlling] {
    var itemControllers: [ItemControlling] = textViewModels.map { DefaultItemController(
      item: $0,
      viewType: TextView.self
    ) }
    if let headerViewModel = headerViewModel {
      print("append")
      let headerItemController = DefaultItemController(
        item: headerViewModel,
        viewType: HeaderView.self
      ) 
      itemControllers.append(headerItemController)
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
    var itemControllers: [ItemControlling] = textViewModels.map { DefaultItemController(
      item: $0,
      viewType: TextView.self
    ) }
    itemControllers.append(DefaultItemController(item: imageViewModel, viewType: ImageView.self))
    return itemControllers
  }
}

// ListController

class TimelineListController: ListControlling {
  var sectionControllers: [SectionControlling]
  init(viewModel: TimelineViewModel) {
    let postSections: [SectionControlling] = viewModel.postViewModels.map { PostSection(
      headerViewModel: $0.headerViewModel,
      textViewModels: $0.textViewModels
    ) }
    let photoPostSections: [SectionControlling] = viewModel.photoPostViewModels.map { PhotoPostSection(
      imageViewModel: $0.imageViewModel,
      textViewModels: $0.textViewModels
    ) }
    self.sectionControllers = postSections + photoPostSections
  }
}

// DefaultListViewController
let headerViewModel1 = HeaderViewModel(headerText: "HeaderViewModel")
let textViewModel1 = TextViewModel(text: "TextViewModel 1")
let textViewModel2 = TextViewModel(text: "TextViewModel 2")
let textViewModel3 = TextViewModel(text: "TextViewModel 3")
let postViewModel = PostViewModel(
  headerViewModel: headerViewModel1,
  textViewModels: [textViewModel1, textViewModel2]
)
let imageViewModel = ImageViewModel(image: nil)
let photoPostViewModel = PhotoPostViewModel(
  imageViewModel: imageViewModel,
  textViewModels: [textViewModel1, textViewModel3]
)
let timelineViewModel = TimelineViewModel(
  postViewModels: [postViewModel],
  photoPostViewModels: [photoPostViewModel]
)
let timelineListController = TimelineListController(viewModel: timelineViewModel)

let defaultListViewController = DefaultListViewController(listController: timelineListController)
defaultListViewController.collectionView.alwaysBounceVertical = true
PlaygroundPage.current.liveView = defaultListViewController
