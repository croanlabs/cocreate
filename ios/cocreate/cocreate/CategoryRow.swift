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

struct CategoryRow: View {
    var categoryName: String
    var items: [Song]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(self.categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(self.items) { song in
                        NavigationLink(
                            destination: SongDetail(
                                songId: song.id
                            )
                        ) {
                            CategoryItem(song: song)
                        }
                    }
                }
            }
            .frame(height: 185)        }
    }
}

struct CategoryItem: View {
    var song: Song
    var body: some View {
        VStack(alignment: .leading) {
            song.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(song.name)
                .foregroundColor(.primary)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        return CategoryRow(
            categoryName: songCatalog.songs[0].category.rawValue,
            items: Array(songCatalog.songs.prefix(4))
        )
    }
}
