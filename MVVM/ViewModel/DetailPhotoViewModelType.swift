//
//  DetailPhotoViewModelType.swift
//  MVVM
//
//  Created by belga on 20/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import Foundation



protocol DetailPhotoViewModelDelegateType: class
{
  func detailDidLoad(viewModel: PhotoViewModelType)
  func detailErrorReceived( error: Swift.Error)
}



protocol DetailPhotoViewModelType
{
  var model: PhotoModelType? { get set }
  var viewDelegate: DetailPhotoViewModelDelegateType? { get set }
  var detail: PhotoViewModelType? { get }
}
