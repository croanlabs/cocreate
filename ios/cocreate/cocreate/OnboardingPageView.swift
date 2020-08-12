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

struct OnboardingPageView: View {
    
    var imageString: String
    var title: String
    var caption: String
    
    var body: some View {

        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                    .scaledToFit()
                    .frame(width: 350.0, height: 350.0, alignment: .center)
            }
            Group {
                Text(title)
                    .font(.title)
                Text(caption)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(width: 300, height: 50, alignment: .leading)
                    .lineLimit(nil)
            }
        }
        .padding()
        
    }
}

struct OnboardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnboardingPageView(imageString: "frustratedsongwriter", title: "Title", caption: "Caption")
           
        }
        
    }
}

