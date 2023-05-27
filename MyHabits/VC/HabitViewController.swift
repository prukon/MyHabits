//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 11.05.2023.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    enum TypeOpen {
    case add
    case edit
    }
    
    //MARK: - Property
    var type: TypeOpen = .add

    let store = HabitsStore.shared
    var selectedDate = Date()
    var habit: Habit!
    var numberOfHabit = Int()
    var habitCollectionViewCell = HabitCollectionViewCell()
    var habitsViewController = HabitsViewController()
    
    lazy var delButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(delHabit), for: .touchUpInside)
        button.backgroundColor = .red
        button.tintColor = .white
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.alpha = 0
        return button
    }()
    
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
    
    private let nameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 13)
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont(name: "SFProText-Regular", size: 17)
        textField.font = UIFont.systemFont(ofSize: 17)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldShouldReturn), for: .editingDidEndOnExit)
        
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
        label.textColor = .blue
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
        view.backgroundColor = .white
        
        addSubviews()
        setupContraints()
        setupNC()
        addValues()
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
        contentView.addSubview(delButton)
    }
    
    // Метод делегата для обработки выбранного цвета
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        colorButton.tintColor = viewController.selectedColor
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeStyle = .short
        return formatter
    }()
    
    func addValues() {
        
        if type == .edit {
            textField.text = habit.name
            colorButton.tintColor = habit.color
            let dateString = dateFormatter.string(from: habit.date)
            targetTimeLabel.text = dateString
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(tapSaveButton))
            delButton.alpha = 1
            title = "Изменить"
        }
    }
    
    func setupNC() {
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(goBack))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(tapSaveButton))
               title = "Создать"
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
        
        targetTimeLabel.text = dateToString(date: sender.date)
    }
    
    @objc func tapSaveButton() {
        if type == .add {
            if !textField.text!.isEmpty{
                habit = Habit(name: textField.text ?? " ",
                              date: selectedDate,
                              color: colorButton.tintColor)
                let store = HabitsStore.shared
                store.habits.append(habit)
                habitsViewController.progressCollectionViewCell.setProgress(with: HabitsStore.shared.todayProgress)
                habitsViewController.reloadCollectionView()
                self.navigationController?.popViewController(animated: true)
            } else {
                textField.shake()
                return
            }
        }
        else if type == .edit {
            store.habits[numberOfHabit].name = textField.text ?? " "
            store.habits[numberOfHabit].color = colorButton.tintColor
            store.habits[numberOfHabit].date = selectedDate

            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc func delHabit() {
        showAlert(title: "Удаление привычки", message: "Вы точно хотите удалить привычку?")
    }
    
    @objc private func textFieldShouldReturn() -> Bool {
        return view.endEditing(true)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default) {_ in
            self.store.habits.remove(at: self.numberOfHabit)
            self.navigationController?.popToRootViewController(animated: true)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) {_ in
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
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
            
            //            delButton
            delButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20),
            delButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            delButton.widthAnchor.constraint(equalToConstant: 300),
            delButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
