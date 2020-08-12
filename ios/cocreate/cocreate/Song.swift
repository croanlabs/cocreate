//  Copyright © 2020 Croan Labs.

//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at

//      http://www.apache.org/licenses/LICENSE-2.0

//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import SwiftUI
import CoreLocation

struct Song: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    fileprivate var imageName: String
    var artist: String
    var category: Category
    var isFavorite: Bool
    var isFeatured: Bool

    enum Category: String, CaseIterable, Codable, Hashable {
        case folk = "Folk"
        case jazz = "Jazz"
        case edm = "EDM"
        case rock = "Rock"
    }
}

extension Song {
    var image: Image {
        ImageStore.shared.image(name: imageName)
    }
}

