//
//  DetailPhotoViewModel.swift
//  MVVM
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation

class DetailPhotoViewModel : DetailPhotoViewModelType {
  weak var viewDelegate: DetailPhotoViewModelDelegateType?
  var id:Int
  
  fileprivate(set) var detail: PhotoViewModelType? {
    didSet {
      viewDelegate?.detailDidLoad(viewModel: detail!)
    }
  }
  
  var model: PhotoModelType? {
    didSet {
      model?.getPhoto(id: self.id,
        success: { (result) in
          self.detail = PhotoViewModel(photo: result)
        }, fail: { (error) in
          self.viewDelegate?.detailErrorReceived(error: error)
        })
    }
  }
  
  init(id:Int) {
    self.id = id
  }
  
}
