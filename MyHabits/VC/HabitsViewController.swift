//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 11.05.2023.
//

import UIKit

class HabitsViewController: UIViewController {
   
    //MARK: - Property

    lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Button"
        button.image = UIImage(systemName: "plus")
        button.target = self
        button.action = #selector(tapBarButton)
        return button
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        navigationItem.rightBarButtonItem = barButton

        addSubviews()
//        setupContraints()
        
    }
    //MARK: - Functions

    func addSubviews() {
//        view.addSubview(menuButton)
    }
    
    //MARK: - Action

    @objc func tapBarButton() {
        print(1)
    }
    
    //MARK: - Constraints

}
