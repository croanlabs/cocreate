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

struct SongRow: View {
    var song: Song
    
    var body: some View {
        HStack {
            song.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(song.name)
            Spacer()
            
            if song.isFavorite {
                Image(systemName: "heart.fill")
                    .imageScale(.medium)
                    .foregroundColor(.gray)
            }
        }.padding(10)
    }
}

struct SongRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SongRow(song: songCatalog.songs[0])
            SongRow(song: songCatalog.songs[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
