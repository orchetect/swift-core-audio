//
//  Date Utilities.swift
//  SwiftCoreAudio • https://github.com/orchetect/swift-core-audio
//  © 2026 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension Date {
    /// Returns `true` if the date is contained within the current day.
    var isToday: Bool {
        let nowDateComponents = Calendar.current.dateComponents(in: .current, from: .now)
        let dateComponents = Calendar.current.dateComponents(in: .current, from: self)

        let isToday = nowDateComponents.year == dateComponents.year
            && nowDateComponents.month == dateComponents.month
            && nowDateComponents.day == dateComponents.day

        return isToday
    }

    /// If `self` is "today", just the time is returned. Otherwise the date and time is returned.
    var autoSizedFormatted: String {
        if isToday {
            formatted(date: .omitted, time: .standard)
        } else {
            formatted(date: .numeric, time: .standard)
        }
    }

    /// Returns the date formatted as a relative date string.
    var localizedRelativeFormatted: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.formattingContext = .listItem
        formatter.dateTimeStyle = .numeric
        return formatter.localizedString(for: self, relativeTo: .now)
    }
}
