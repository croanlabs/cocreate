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

struct SongDetail: View {
    var songId: Int
    
    var songIndex: Int {
        songCatalog.songs.firstIndex(where: { $0.id == songId })!
    }
    
    var body: some View {
        VStack {
            RoundedCornerImage(songImage: songCatalog.songs[songId-1001].image)
        
            VStack(alignment: .leading) {
                HStack {
                    Text(songCatalog.songs[songId-1001].artist)
                        .font(.title)

                    Button(action: {
                        songCatalog.songs[self.songIndex].isFavorite.toggle()
                    }) {
                        if songCatalog.songs[self.songIndex].isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.gray)
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(Color.gray)
                        }
                    }
                }
                
                HStack {
                    Text(songCatalog.songs[songId-1001].name)
                        .font(.subheadline)
                    Spacer()
                    Text(songCatalog.songs[songId-1001].category.rawValue)
                        .font(.subheadline)
                }
            }
            .padding()
        
            Spacer()
        }
            
    }
}

struct SongDetail_Previews: PreviewProvider {
    static var previews: some View {
        SongDetail(songId: 0)
    }
}
