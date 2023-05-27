//
//  DetailsTableViewCell.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 27.05.2023.
//

import UIKit

final class DetailsTableViewCell: UITableViewCell {
    
    //MARK: - Property
    var indexPathCell = Int()
    var appDates = IndexPath()
    var dateOfHabit = Date()
    let dateFormatter = DateFormatter()

    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "date"
        return label
    }()
    
    private let checkMark: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "checkmark")
        image.tintColor = .blue
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: - lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        checkMark.isHidden = true
    }
    
    //MARK: - Functions
    
    private func setupSubviews() {
        addSubview(dateLabel)
        addSubview(checkMark)
    }
    
    func setupCell(model: [Date]) {
        dateOfHabit = model[store.dates.count - (appDates.row + 1)] // mapping from larger to smaller date in tableView
        dateFormatter.dateFormat = "d MMM yyyy"
        dateLabel.text = dateFormatter.string(from: dateOfHabit)
        
        if store.habit(store.habits[indexPathCell], isTrackedIn: dateOfHabit) == true {
            checkMark.isHidden = false
        }
    }
    
    //MARK: - layout
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11),
            
            checkMark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -14),
            checkMark.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkMark.heightAnchor.constraint(equalToConstant: 26),
            checkMark.widthAnchor.constraint(equalToConstant: 26)
        ])
    }
}
