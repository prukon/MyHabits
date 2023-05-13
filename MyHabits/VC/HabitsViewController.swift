//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 12.05.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - Properties
    
    
    let store = HabitsStore.shared
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemGray2
        collectionView.dataSource = self
        
        collectionView.register(
            ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.identifier)
        
        collectionView.register(
            HabitCollectionViewCell.self, forCellWithReuseIdentifier: HabitCollectionViewCell.identifier)
        
        
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Button"
        button.image = UIImage(systemName: "plus")
        button.target = self
        button.action = #selector(tapBarButton)
        return button
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 34)
        label.text = "Сегодня"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = barButton
        navigationItem.titleView = titleLabel
        addSubviews()
        setupContraints()
        
    }
    
    //MARK: - Functions
    func addSubviews() {
        view.addSubview(collectionView)
        
    }
    
    //MARK: - Action
    
    @objc func tapBarButton() {
        let habitViewController = HabitViewController()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationItem.backBarButtonItem = backButton
        navigationController?.pushViewController(habitViewController, animated: true)
    }
    
    //MARK: - Constraints
    
    func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ])
    }
    
}

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    // MARK:   numberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        } else {
            return store.habits.count
            
        }
    }
    
    // MARK:   cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if  indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
            cell.setupCell(habit: store.habits[indexPath.row])
            
            cell.waterButton.tag = indexPath.row
//            cell.waterButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            
//            self.collectionView.reloadData()
            return cell
        }
    }
    
    
    
    @objc  func editButtonTapped() -> Void {
        print("Hello Edit Button")
    }
//    @objc  func buttonClicked(sender : UIButton ){
//        if !store.habits[sender.tag].isAlreadyTakenToday {
//            sender.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
////            HabitsStore.shared.track()
//
//            //Как мне здесь вызвать метод HabitsStore.shared.track() для затрекивания привычки?
//
//            //Пробовал передать Habits параметры метода buttonClicked, но методы @objc не принимают два параметра.
//
//        }
//    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 1}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = (collectionView.bounds.width)
            //                let height = (collectionView.bounds.height)
            
            return CGSize(width: width, height: 100)
        } else {
            let width = (collectionView.bounds.width)
            //                let height = (collectionView.bounds.height)
            
            return CGSize(width: width, height: 160)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
}


