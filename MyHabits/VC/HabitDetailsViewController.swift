//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 27.05.2023.
//

import UIKit

class HabitDetailsViewController: UIViewController  {
    
    //MARK: - Property
    
    var habit: Habit!
    var numberOfHabit = Int()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DetailsTableViewCell.self, forCellReuseIdentifier: DetailsTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    //MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupContraints()
        setupNC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - functions
    
    func setupNC() {
        self.navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = habit.name
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editHabit))
        
        navigationItem.rightBarButtonItem?.tintColor = .blue
    }
    
    @objc func editHabit() {
        let habitVC = HabitViewController()
        habitVC.habit = self.habit
        habitVC.numberOfHabit = numberOfHabit
        habitVC.type = .edit
        self.navigationController?.pushViewController(habitVC, animated: true)
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Constraints
    func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HabitDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        store.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifier, for: indexPath) as! DetailsTableViewCell
        cell.indexPathCell = numberOfHabit
        cell.appDates = indexPath
        
        cell.setupCell(model: store.dates)
        if indexPath.row == 0 {
            cell.dateLabel.text = "Сегодня"
        } else if indexPath.row == 1 {
            cell.dateLabel.text = "Вчера"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "АКТИВНОСТЬ"
    }
}
