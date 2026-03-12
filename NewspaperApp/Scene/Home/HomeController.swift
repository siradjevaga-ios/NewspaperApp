//
//  HomeController.swift
//  NewspaperApp
//
//  Created by user on 03.03.26.
//

import UIKit

class HomeController: UIViewController {
    private let viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewModel()
        
    }
    func configureViewModel() {
        viewModel.getNewsList()
        viewModel.success = { [weak self] in
            print("Xeberler geldi. Meqalelerin sayi: \(self?.viewModel.articles.count ?? 0)")
        }
        viewModel.error = { errorMessage in
            print(errorMessage)
        }
    }
}
