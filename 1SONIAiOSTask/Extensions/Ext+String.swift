//
//  Ext++String.swift
//  1SONIAiOSTask
//
//  Created by Mekhriddin Jumaev on 10/10/22.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
