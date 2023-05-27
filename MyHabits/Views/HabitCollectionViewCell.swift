//
//  HabitsCollectionViewCell.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 12.05.2023.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property
    
    private var habit: Habit!
    var onStateBtnClick: (() ->Void)!
    var editHabit: (() ->Void)!
    
    //MARK: Water
    private lazy var waterView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHabbitButton)))
        return view
    }()
    
    private let waterHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Выпить стакан воды"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        return label
    }()
    
    private let waterRegularLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Каждый день в 7:30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .systemGray2
        return label
    }()
    
    private let waterCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Счетчик: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.tintColor = .systemGray
        return label
    }()
    
    private lazy var  waterButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let store = HabitsStore.shared
    private var progressCollectionViewCell = ProgressCollectionViewCell()

    //MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func addSubviews(){
        contentView.addSubview(waterView)
        waterView.addSubview(waterHeaderLabel)
        waterView.addSubview(waterRegularLabel)
        waterView.addSubview(waterCountLabel)
        waterView.addSubview(waterButton)
    }
    
    func setupCell(habit: Habit, onStateBtnClick: @escaping () -> Void) {
        self.habit = habit
        waterHeaderLabel.text = habit.name
        waterHeaderLabel.textColor = habit.color
        waterRegularLabel.text = habit.dateString
        waterCountLabel.text = "Счетчик: \(habit.trackDates.count)"
        waterButton.tintColor = habit.color
        
        if habit.isAlreadyTakenToday {
            waterButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
        } else {
            waterButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
    }
    
    //MARK: Action
    
//    Клик по ячейке для изменения привычки
    @objc func tapHabbitButton() {
        if let action =  self.editHabit { action() }
    }
    
    //клик по активации привычки
    @objc  func buttonClicked(sender : UIButton ){
        if !habit.isAlreadyTakenToday {
            waterButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            HabitsStore.shared.track(habit)
        }
        onStateBtnClick()
    }
    
    //MARK: - Constraints
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            
            //            waterView
            waterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            waterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            waterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            waterView.heightAnchor.constraint(equalToConstant: 130),
            
            //            waterHeaderLabel
            waterHeaderLabel.topAnchor.constraint(equalTo: waterView.topAnchor, constant: 20),
            waterHeaderLabel.leadingAnchor.constraint(equalTo: waterView.leadingAnchor, constant: 20),
            
            //            waterRegularLabel
            waterRegularLabel.topAnchor.constraint(equalTo: waterHeaderLabel.bottomAnchor, constant: 4),
            waterRegularLabel.leadingAnchor.constraint(equalTo: waterView.leadingAnchor, constant: 20),
            
            //            waterCountLabel
            waterCountLabel.topAnchor.constraint(equalTo: waterRegularLabel.bottomAnchor, constant: 30),
            waterCountLabel.leadingAnchor.constraint(equalTo: waterView.leadingAnchor, constant: 20),
            
            //            waterButton
            waterButton.trailingAnchor.constraint(equalTo: waterView.trailingAnchor, constant: -25),
            waterButton.centerYAnchor.constraint(equalTo: waterView.centerYAnchor),
            waterButton.widthAnchor.constraint(equalToConstant: 38),
            waterButton.heightAnchor.constraint(equalToConstant: 38),
        ])
    }
}
