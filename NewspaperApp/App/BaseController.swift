//
//  BaseController.swift
//  NewspaperApp
//
//  Created by user on 13.03.26.
//

import UIKit

class BaseController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configureUI()
        configureViewModel()
        configureConstraints()
    }
    
    func configureUI() {}
    
    func configureViewModel() {}
    
    func configureConstraints() {}
}
