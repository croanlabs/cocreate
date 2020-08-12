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

struct SongList: View {
    @EnvironmentObject var userPrefs: UserPreferences
    
    var body: some View {
        List {
            Toggle(isOn: $userPrefs.showFavoritesOnly) {
                Text("Favorites only")
            }
            
            ForEach(songCatalog.songs) { song in
                if !self.userPrefs.showFavoritesOnly || song.isFavorite {
                    NavigationLink(destination: SongDetail(songId: song.id)) {
                        SongRow(song: song)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Songs"))
    }
}

struct SongList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SongList()
                .environmentObject(UserPreferences())
        }
    }
}
