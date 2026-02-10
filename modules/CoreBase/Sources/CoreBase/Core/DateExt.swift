//
//  DateExt.swift
//  CoreBase
//
//  Created by Kevin Wu on 2/5/26.
//

import Foundation

// now.formatted() 用的是系统选择的日期格式
// now.formatted(.dateTime) 9/20/2025, 12:21
// now.formatted(.iso8601) 2025-09-10T04:21:46Z
// now.formatted(date: .complete, time: .complete)

// DateFormatter 不知如何使用系统选择的日期格式
// df.dateStyle = .full
// df.timeStyle = .full
// df.locale = Locale(identifier: "zh_TW") 结果会包含中文
//
// .full:   Thursday, September 11, 2025
// .long:   September 11, 2025
// .medium: Sep 11, 2025
// .short:  11.09.2025
//
// .full:   09:46:57 China Standard Time
// .long:   09:46:57 GMT+8
// .medium: 09:46:57
// .short:  09:46

// print(date)          // time-zone:0
// print(df.str(date))  // time-zone:local
//
// TimeZone.knownTimeZoneIdentifiers
// df.timeZone = TimeZone(identifier: "GMT")
extension Date {
  // 16_2450_3116
  // 10_0000_0000     ≈ 30 years
  // 10_0000_0000_000 ≈ 30000 years
  public init?(timestamp: Double?) { // LABEL
    if let timestamp, timestamp > 0 {
      self.init(timeIntervalSince1970: timestamp <= 99_9999_9999 ? timestamp : timestamp / 1000)
    } else {
      return nil
    }
  }

  public var start: Date {
    Calendar.current.startOfDay(for: self)
  }
  public var yesterday: Date {
    Date(timeIntervalSince1970: timeIntervalSince1970 - 86400)
  }
  public var tomorrow: Date {
    Date(timeIntervalSince1970: timeIntervalSince1970 + 86400)
  }
  public func added(_ seconds: Double) -> Date {
    Date(timeIntervalSince1970: timeIntervalSince1970 + seconds)
  }

  public var isToday: Bool {
    Calendar.current.isDateInToday(self)
  }
  public var isYesterday: Bool {
    Calendar.current.isDateInYesterday(self)
  }
  public var isTomorrow: Bool {
    Calendar.current.isDateInTomorrow(self)
  }
  public func isSameDay(_ date: Date?) -> Bool {
    guard let date = date else { return false }
    return Calendar.current.isDate(self, inSameDayAs: date)
  }
}

extension DateFormatter {
  public func string(_ value: Date?) -> String? {
    guard let value else { return nil }
    return string(from: value)
  }
  public func date(_ value: String?) -> Date? {
    guard let value, !value.isEmpty else { return nil }
    return date(from: value)
  }
}
extension ISO8601DateFormatter {
  public func string(_ value: Date?) -> String? {
    guard let value else { return nil }
    return string(from: value)
  }
  public func date(_ value: String?) -> Date? {
    guard let value, !value.isEmpty else { return nil }
    return date(from: value)
  }
}
