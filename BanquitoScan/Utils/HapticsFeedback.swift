//
//  HapticsFeedback.swift
//  BanquitoScan
//
//  Created by Gaspar Dolcemascolo on 08/03/2025.
//

import UIKit

func triggerHapticFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.prepare()
    generator.notificationOccurred(type)
}
