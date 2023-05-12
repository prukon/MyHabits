//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 11.05.2023.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    //MARK: - Property
    
    var selectedDate = Date()
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .systemGray6
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var saveButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Сохранить"
        button.target = self
        button.action = #selector(tapSaveButton)
        return button
    }()
    
    lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.style = .plain
        button.title = "Отменить"
//        button.image = UIImage(systemName: "plus")
        button.target = self
//        button.action = #selector(tapBarButton)
        return button
    }()
    
    private let nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let colorLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "ЦВЕТ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  colorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(systemName: "circle.fill"), for: .normal)
        button.tintColor = .blue
        button.addTarget(self, action: #selector(tapColorButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let timeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "ВРЕМЯ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let focusTimeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "Каждый день в "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let targetTimeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "11:00 PM"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.isEnabled = true
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Создать"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = saveButton
    
        addSubviews()
        setupContraints()
    }
    
    @objc func backButtonTapped () {
        
    }
    
    //MARK: - Functions
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(textField)
        contentView.addSubview(colorLabel)
        contentView.addSubview(colorButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(focusTimeLabel)
        contentView.addSubview(targetTimeLabel)
        contentView.addSubview(datePicker)
    }
    
    // Метод делегата для обработки выбранного цвета
     func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
         colorButton.tintColor = viewController.selectedColor
     }
    
    //MARK: - Action
    @objc func tapColorButton() {
        let colorPicker = UIColorPickerViewController()
        colorPicker.selectedColor = colorButton.tintColor
           colorPicker.delegate = self
           present(colorPicker, animated: true, completion: nil)
    }
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
         selectedDate = sender.date
           // Вы можете использовать выбранное значение даты здесь
           // Например, можно вывести его в консоль
           print(selectedDate)
    }
//    let enteredText = textField.text

    
    @objc func tapSaveButton() {
        let newHabit = Habit(name: textField.text ?? " ",
                             date: selectedDate,
                             color: colorButton.tintColor)
        let store = HabitsStore.shared
        store.habits.append(newHabit)
        
        self.navigationController?.popViewController(animated: true)

    }
    
    //MARK: - Constraints
    
    func setupContraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            //            scrollView
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            //            contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            //            nameLabel
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            //            textField
            textField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            //            colorLabel
            colorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            
            //            colorButton
            colorButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 15),
            colorButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            colorButton.widthAnchor.constraint(equalToConstant: 30),
            colorButton.heightAnchor.constraint(equalToConstant: 30),

            

            //            timeLabel
            timeLabel.topAnchor.constraint(equalTo: colorButton.bottomAnchor, constant: 15),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            
            //            focusTimeLabel
            focusTimeLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            focusTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            
            //            targetTimeLabel
            targetTimeLabel.topAnchor.constraint(equalTo: focusTimeLabel.topAnchor),
            targetTimeLabel.leadingAnchor.constraint(equalTo: focusTimeLabel.trailingAnchor, constant: 0),
            
//            datePicker
            datePicker.topAnchor.constraint(equalTo: focusTimeLabel.bottomAnchor),
            datePicker.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            datePicker.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            

        ])
    }
    
    
}
