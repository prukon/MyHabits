//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 11.05.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - Property
    
    private let finalView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
 
    //MARK: Result

    private let resultView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let resultSlider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = .blue
        slider.minimumValue = 0.0
        slider.maximumValue = 100.0
        slider.value = 40.0
        slider.maximumTrackTintColor = .systemGray4
        slider.minimumTrackTintColor = UIColor(red: 0.63, green: 0.08, blue: 0.8, alpha: 1.0)
        slider.setThumbImage(UIImage(), for: .normal)
        slider.setThumbImage(UIImage(), for: .highlighted)
        slider.isEnabled = true
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let resultNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Все получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.backgroundColor = .green
        return label
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0%"
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.backgroundColor = .red
        return label
    }()
    
//MARK: Water
    private let waterView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let waterHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Выпить стакан воды"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        //        label.backgroundColor = .green
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
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Activity
        private let activityView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        
        private let activityHeaderLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 17)
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = "Сделать зарядку"
            label.translatesAutoresizingMaskIntoConstraints = false
//            label.textColor = .green
            label.textColor = UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1.0)

            //        label.backgroundColor = .green
            return label
        }()
        
        private let activityRegularLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 12)
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = "Каждый день в 7:00"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .systemGray2
            return label
        }()
        
        private let activityCountLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 13)
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = "Счетчик: 3"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .systemGray
            return label
        }()
        
        private lazy var  activityButton: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            button.tintColor = UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1.0)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    //MARK: dailyRoutine
        private let dailyRoutineView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        
        private let dailyRoutineHeaderLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 17)
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = "Лечь спать до 23:00 и проснуться в 7:00"
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1.0)
            return label
        }()
        
        private let dailyRoutineRegularLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 12)
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = "Каждый день в 22:30"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .systemGray2
            return label
        }()
        
        private let dailyRoutineCountLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 13)
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = "Счетчик: 4"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .systemGray
            return label
        }()
        
        private lazy var  dailyRoutineButton: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            button.tintColor = UIColor(red: 98/255, green: 54/255, blue: 255/255, alpha: 1.0)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    //MARK: Reading
        private let readingView: UIView = {
            let view = UIView()
            view.layer.cornerRadius = 10
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .white
            return view
        }()
        
        private let readingHeaderLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 17)
            label.font = UIFont.systemFont(ofSize: 17)
            label.text = "Сделать зарядку"
            label.translatesAutoresizingMaskIntoConstraints = false
//            label.textColor = .green
            label.textColor = UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1.0)

            //        label.backgroundColor = .green
            return label
        }()
        
        private let readingRegularLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 12)
            label.font = UIFont.systemFont(ofSize: 12)
            label.text = "Каждый день в 7:00"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .systemGray2
            return label
        }()
        
        private let readingCountLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont(name: "SFProText-Regular", size: 13)
            label.font = UIFont.systemFont(ofSize: 13)
            label.text = "Счетчик: 3"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.tintColor = .systemGray
            return label
        }()
        
        private lazy var  readingButton: UIButton = {
            let button = UIButton(type: .system)
            button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
            button.tintColor = UIColor(red: 29/255, green: 179/255, blue: 34/255, alpha: 1.0)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

    
    //MARK: - LifeCycle
    
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
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
            
        contentView.addSubview(resultView)
        resultView.addSubview(resultLabel)
        resultView.addSubview(resultNameLabel)
        resultView.addSubview(resultSlider)
        
        contentView.addSubview(waterView)
        waterView.addSubview(waterHeaderLabel)
        waterView.addSubview(waterRegularLabel)
        waterView.addSubview(waterCountLabel)
        waterView.addSubview(waterButton)
        
        contentView.addSubview(activityView)
        activityView.addSubview(activityHeaderLabel)
        activityView.addSubview(activityRegularLabel)
        activityView.addSubview(activityCountLabel)
        activityView.addSubview(activityButton)
        
        contentView.addSubview(dailyRoutineView)
        dailyRoutineView.addSubview(dailyRoutineHeaderLabel)
        dailyRoutineView.addSubview(dailyRoutineRegularLabel)
        dailyRoutineView.addSubview(dailyRoutineCountLabel)
        dailyRoutineView.addSubview(dailyRoutineButton)
        
        contentView.addSubview(readingView)
        readingView.addSubview(readingHeaderLabel)
        readingView.addSubview(readingRegularLabel)
        readingView.addSubview(readingCountLabel)
        readingView.addSubview(readingButton)
        
        contentView.addSubview(finalView)
        
    }
    
    //MARK: - Action
    
    @objc func tapBarButton() {
        print(1)
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
            
            //            resultView (white)
            resultView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            resultView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resultView.bottomAnchor.constraint(equalTo: resultSlider.bottomAnchor, constant: 20),
            
            //            resultLabel
            resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10),
            resultLabel.heightAnchor.constraint(equalToConstant: 30),
            
            //            resultNameLabel
            resultNameLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 10),
            resultNameLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10),
            resultNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            //            resultSlider
            resultSlider.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10),
            resultSlider.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10),
            resultSlider.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10),
            resultSlider.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -10),
            
            //            waterView
            waterView.topAnchor.constraint(equalTo: resultView.bottomAnchor, constant: 20),
            waterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            waterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            waterView.bottomAnchor.constraint(equalTo: waterCountLabel.bottomAnchor, constant: 20),
            
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

            
            //            activityView
            activityView.topAnchor.constraint(equalTo: waterView.bottomAnchor, constant: 20),
            activityView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            activityView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            activityView.bottomAnchor.constraint(equalTo: activityCountLabel.bottomAnchor, constant: 20),
            
//            activityHeaderLabel
            activityHeaderLabel.topAnchor.constraint(equalTo: activityView.topAnchor, constant: 20),
            activityHeaderLabel.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 20),
            
//            activityRegularLabel
            activityRegularLabel.topAnchor.constraint(equalTo: activityHeaderLabel.bottomAnchor, constant: 4),
            activityRegularLabel.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 20),
            
            //            activityCountLabel
            activityCountLabel.topAnchor.constraint(equalTo: activityRegularLabel.bottomAnchor, constant: 30),
            activityCountLabel.leadingAnchor.constraint(equalTo: activityView.leadingAnchor, constant: 20),
            
//            activityButton
            activityButton.trailingAnchor.constraint(equalTo: activityView.trailingAnchor, constant: -25),
            activityButton.centerYAnchor.constraint(equalTo: activityView.centerYAnchor),
            activityButton.widthAnchor.constraint(equalToConstant: 38),
            activityButton.heightAnchor.constraint(equalToConstant: 38),
            
            //            dailyRoutineView
            dailyRoutineView.topAnchor.constraint(equalTo: activityView.bottomAnchor, constant: 20),
            dailyRoutineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            dailyRoutineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dailyRoutineView.bottomAnchor.constraint(equalTo: dailyRoutineCountLabel.bottomAnchor, constant: 20),
            
//            activityHeaderLabel
            dailyRoutineHeaderLabel.topAnchor.constraint(equalTo: dailyRoutineView.topAnchor, constant: 20),
            dailyRoutineHeaderLabel.leadingAnchor.constraint(equalTo: dailyRoutineView.leadingAnchor, constant: 20),
            dailyRoutineHeaderLabel.trailingAnchor.constraint(equalTo: dailyRoutineView.trailingAnchor, constant: -80),
            
//            activityRegularLabel
            dailyRoutineRegularLabel.topAnchor.constraint(equalTo: dailyRoutineHeaderLabel.bottomAnchor, constant: 4),
            dailyRoutineRegularLabel.leadingAnchor.constraint(equalTo: dailyRoutineView.leadingAnchor, constant: 20),
            
            //            activityCountLabel
            dailyRoutineCountLabel.topAnchor.constraint(equalTo: dailyRoutineRegularLabel.bottomAnchor, constant: 30),
            dailyRoutineCountLabel.leadingAnchor.constraint(equalTo: dailyRoutineView.leadingAnchor, constant: 20),
            
//            activityButton
            dailyRoutineButton.trailingAnchor.constraint(equalTo: dailyRoutineView.trailingAnchor, constant: -25),
            dailyRoutineButton.centerYAnchor.constraint(equalTo: dailyRoutineView.centerYAnchor),
            dailyRoutineButton.widthAnchor.constraint(equalToConstant: 38),
            dailyRoutineButton.heightAnchor.constraint(equalToConstant: 38),

            
            //            readingView
            readingView.topAnchor.constraint(equalTo: dailyRoutineView.bottomAnchor, constant: 20),
            readingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            readingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            readingView.bottomAnchor.constraint(equalTo: readingCountLabel.bottomAnchor, constant: 20),
//            readingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
//            readingHeaderLabel
            readingHeaderLabel.topAnchor.constraint(equalTo: readingView.topAnchor, constant: 20),
            readingHeaderLabel.leadingAnchor.constraint(equalTo: readingView.leadingAnchor, constant: 20),
            
//            readingRegularLabel
            readingRegularLabel.topAnchor.constraint(equalTo: readingHeaderLabel.bottomAnchor, constant: 4),
            readingRegularLabel.leadingAnchor.constraint(equalTo: readingView.leadingAnchor, constant: 20),
            
            //            readingCountLabel
            readingCountLabel.topAnchor.constraint(equalTo: readingRegularLabel.bottomAnchor, constant: 30),
            readingCountLabel.leadingAnchor.constraint(equalTo: readingView.leadingAnchor, constant: 20),
            
//            readingButton
            readingButton.trailingAnchor.constraint(equalTo: readingView.trailingAnchor, constant: -25),
            readingButton.centerYAnchor.constraint(equalTo: readingView.centerYAnchor),
            readingButton.widthAnchor.constraint(equalToConstant: 38),
            readingButton.heightAnchor.constraint(equalToConstant: 38),
            

            finalView.topAnchor.constraint(equalTo: readingView.bottomAnchor, constant: 10),
            finalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            
        ])
    }
    
}
