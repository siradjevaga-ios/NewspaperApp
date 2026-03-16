//
//  String+ext.swift
//  NewspaperApp
//
//  Created by user on 16.03.26.
//

import Foundation

extension String {
    func setRelativeTime() -> String {
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: self) else { return self }
        let formatter = RelativeDateTimeFormatter()
        return formatter.localizedString(for: date, relativeTo: Date())
    }
}

