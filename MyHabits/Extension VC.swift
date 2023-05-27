//
//  Extension VC.swift
//  MyHabits
//
//  Created by Evgeniy Ustyan on 12.05.2023.
//

import UIKit

extension UIView {
    
    //Авто создание идентификаторов
    static var identifier: String {
        String(describing: self)
    }
    
    //Подергивание строки при неправильном вводе
    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = 5) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}

extension UIViewController {
    
    //Конвертация даты в строку
    func dateToString(date: Date) -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "ru_RU")
            formatter.timeStyle = .short
            return formatter
        }()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
}

