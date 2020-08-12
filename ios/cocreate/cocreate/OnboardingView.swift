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

struct OnboardingView: View {
    
    var titles: [String]
    var captions: [String]
    var subviews: [UIHostingController<OnboardingPageView>]
 
    init() {
        titles = ["Frustrated Songwriter?", "Need Help With Lyrics?", "Need A Great Solo Track?", "Or A Producer?", "Take Control"]
     
        captions =  ["Struggling to finish your masterpiece?", "Bring your song to the next level with great lyrics.", "Invite other musicians to add parts.", "Bring in a great producer to take the session to the next level.", "Share in the ownership of the music you co-create."]
    
        subviews = [
            UIHostingController(rootView: OnboardingPageView(imageString: "frustratedsongwriter", title: titles[0], caption:captions[0])),
            UIHostingController(rootView: OnboardingPageView(imageString: "needhelp", title: titles[1], caption: captions[1])),
            UIHostingController(rootView: OnboardingPageView(imageString:  "musicians", title: titles[2], caption: captions[2])),
            UIHostingController(rootView: OnboardingPageView(imageString: "producer", title: titles[3], caption:captions[3])),
            UIHostingController(rootView: OnboardingPageView(imageString:  "happyoutcome", title: titles[4], caption:captions[4]))
        ]
    }
    
    @State var currentPageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            OnboardingPageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(height: 450)
            HStack {
                OnboardingPageControl(numberOfPages: subviews.count, currentPageIndex: $currentPageIndex)
                Spacer()
                Button(action: {
                    if self.currentPageIndex+1 == self.subviews.count {
                        self.currentPageIndex = 0
                    } else {
                        self.currentPageIndex += 1
                    }
                }) {
                    ButtonContent()
                }
            }
            .padding()
        }
    }
}

struct ButtonContent: View {
    var body: some View {
        Image(systemName: "arrow.right")
        .resizable()
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
        .padding()
        .background(Color.orange)
        .cornerRadius(30)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
