//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 12.05.2023.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Property

    private let store = HabitsStore.shared
    
    private let resultView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
     var progressView: UIProgressView = {
        let progressView = UIProgressView()
         progressView.backgroundColor = .red
         progressView.trackTintColor = .systemGray6
         progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private let resultNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Все получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 12)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
            
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
        
        contentView.addSubview(resultView)
        resultView.addSubview(resultLabel)
        resultView.addSubview(resultNameLabel)
        resultView.addSubview(progressView)
    }
    
    func setProgress(with value: Float) {
        self.resultLabel.text = "\(Int(value * 100))%"
        self.progressView.setProgress(value, animated: true)
    }
    
    //MARK: - Constraints
    
    private func setupContraints() {
        
        NSLayoutConstraint.activate([
            
            //            resultView (подложка)
            resultView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            resultView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            resultView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            resultView.bottomAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 20),
            
            //            resultLabel
            resultLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10),
            resultLabel.heightAnchor.constraint(equalToConstant: 30),
            
            //            resultNameLabel
            resultNameLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 10),
            resultNameLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10),
            resultNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            //            progressView
            progressView.topAnchor.constraint(equalTo: resultNameLabel.topAnchor, constant: 30),
            progressView.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -10),
        ])
    }
}
