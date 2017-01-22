//
//  ViewController.swift
//  MoyaTest
//
//  Created by belga on 10/1/17.
//  Copyright © 2017 GFI. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
  
		
  @IBOutlet var tableView: UITableView!

  var viewModel: ListPhotoViewModelType? {
    willSet {
      viewModel?.viewDelegate = nil
    }
    didSet {
      viewModel?.viewDelegate = self
      refreshDisplay()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    viewModel = ListPhotoViewModel()
    viewModel?.model = PhotoModel()
    
  }
  
  func refreshDisplay() {
     tableView.reloadData()
  }

}

extension ViewController : ListPhotoViewModelTypeDelegate {
  func showError(error: Swift.Error) {
    let alertVC = UIAlertController(title: "Error",
                                    message: error.localizedDescription,
                                    preferredStyle: .alert)
    self.present(alertVC, animated: true, completion: nil)
  }
  
  func itemsDidChange(viewModel: ListPhotoViewModelType) {
    refreshDisplay()
  }
}


extension ViewController : UITableViewDataSource {
  
  
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
  {
    if let viewModel = viewModel {
      return viewModel.numberOfItems
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! TableViewCell
    cell.viewModel = viewModel?.itemAtIndex(indexPath.row)
    return cell
  }
  
}

extension ViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let photoViewModel = viewModel?.itemAtIndex(indexPath.row),
      let id = photoViewModel.id {
      let  detailVC : DetailPhotoViewController = self.storyboard?.instantiateViewController(withIdentifier: "detailPhoto") as! DetailPhotoViewController
      detailVC.id = id
      
      self.navigationController?.pushViewController(detailVC, animated: true)
      self.tableView.deselectRow(at: indexPath, animated: false)
      
    }
    
    
  }
}

