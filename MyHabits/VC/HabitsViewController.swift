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
    let progressCollectionViewCell = ProgressCollectionViewCell()
    
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
        button.image = UIImage(systemName: "plus")
        button.target = self
        button.action = #selector(tapBarButton)
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = barButton
        addSubviews()
        setupContraints()
        setupNavController()
//        addTwoHabbit()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    //MARK: - Functions
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    @objc func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func setupNavController() {
        self.navigationItem.title = "Сегодня"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func addTwoHabbit(){
        store.habits.removeAll()
        store.habits.append(Habit(name: "Погладь кота", date: Date(), color: .red))
        store.habits.append(Habit(name: "Сходить в магазин", date: Date(), color: .purple))
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
            cell.setProgress(with: store.todayProgress)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitCollectionViewCell.identifier, for: indexPath) as! HabitCollectionViewCell
            
            cell.setupCell(habit: store.habits[indexPath.item]){
                self.collectionView.reloadData()
            }
            cell.onStateBtnClick = {
                self.collectionView.reloadData()
            }
            cell.editHabit = {
                let detailVC = HabitDetailsViewController()
                detailVC.habit = self.store.habits[indexPath.item]
                detailVC.numberOfHabit = indexPath.item
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProgressCollectionViewCell.identifier, for: indexPath) as! ProgressCollectionViewCell
        
        header.setProgress(with: store.todayProgress)
        return header
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    private var inset: CGFloat { return 1}
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            let width = (collectionView.bounds.width)
            return CGSize(width: width, height: 100)
        } else {
            let width = (collectionView.bounds.width)
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
