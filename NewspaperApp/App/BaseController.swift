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
        configureUI()
        configureViewModel()
        configureConstraints()
    }
    
    func configureUI() {}
    
    func configureViewModel() {}
    
    func configureConstraints() {}
}
