//
//  MessageSetupTip.swift
//  SugarPolice
//
//  Created by Tyler Lawrence1 on 11/5/24.
//

import Foundation
import TipKit

struct MessageSetupTip: Tip {
    var title: Text = Text("Changing the infraction")
    var message: Text? = Text("Tap anywhere to change the infraction")
}
