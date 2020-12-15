//
//  LocalNotificationScheduler.swift
//  Reportedly
//
//  Created by Minh Pham on 09/12/2020.
//

import Foundation
import UIKit
import UserNotifications

final class LocalNotificationScheduler {
    
    static let shared = LocalNotificationScheduler()
    
    func setupDailyStandupLocalNotifications() {
        // Create the notification content
        let content = UNMutableNotificationContent()
        content.title = Localize.moduleNotificationsDailyReportReminderTitle.localized()
        content.body = Localize.moduleNotificationsDailyReportReminderDescription.localized()
        content.sound = UNNotificationSound.default
                        
        for i in DayIndex.monday...DayIndex.friday {
            // Configure the recurring date.
            var dateComponents = DateComponents()
            dateComponents.calendar = Calendar.current

            dateComponents.weekday = i              // Monday to Friday
            dateComponents.hour = HourValue.nine    // 9:00 hours
               
            // Create the trigger as a repeating event.
            let trigger = UNCalendarNotificationTrigger(
                     dateMatching: dateComponents, repeats: true)
               
            // Create the request
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                        content: content, trigger: trigger)

            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { error in
                if let error = error {
                    log.error("Can't add local notification due to: \(error.localizedDescription)")
                } else {
                    log.info("Add local notification successfully!")
                }
            }
        }
    }
}
