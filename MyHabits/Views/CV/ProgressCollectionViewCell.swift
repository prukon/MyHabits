//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 12.05.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property

    let store = HabitsStore.shared
    
    //result
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
            
    //MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupContraints()
        resultLabel.text = "\(String(Int(store.todayProgress)))%"
//        contentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    private func addSubviews(){
        
        contentView.addSubview(resultView)
        resultView.addSubview(resultLabel)
        resultView.addSubview(resultNameLabel)
        resultView.addSubview(resultSlider)

    }
    //MARK: - Constraints
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            
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
        ])
    }
}
