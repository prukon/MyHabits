//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 11.05.2023.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Property
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 20)
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Привычка за 21 день"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Light", size: 17)
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.text = """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        
        1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.

        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче,
        с чем еще предстоит серьезно бороться.

        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.

        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubviews()
        setupContraints()
    }
        
    //MARK: - Functions
    
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(textInfo)
        contentView.addSubview(headerText)
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
            
//            headerText
            headerText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            headerText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            headerText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

//            textInfo
            textInfo.topAnchor.constraint(equalTo: headerText.bottomAnchor, constant: 20),
            textInfo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textInfo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            ])
    }
}
