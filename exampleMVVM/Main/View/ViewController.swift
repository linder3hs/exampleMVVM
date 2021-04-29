//
//  ViewController.swift
//  exampleMVVM
//
//  Created by Linder Hassinger on 29/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var indicatorActivity: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ViewModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
    }

    private func configureView() {
        indicatorActivity.isHidden = false
        indicatorActivity.startAnimating()
        viewModel.retriveDataList()
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.indicatorActivity.stopAnimating()
                self?.indicatorActivity.isHidden = true
            }
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        let object = viewModel.dataArray[indexPath.row]
        
        cell.textLabel?.text = object.title
        cell.detailTextLabel?.text = object.body
        
        return cell
    }
    
}
