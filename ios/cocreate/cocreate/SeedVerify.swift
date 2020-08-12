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

struct SeedVerify: View {
    
    @EnvironmentObject var seedData: SeedData
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Spacer(minLength: 30)
                        Text("Please select the words in your seed phrase:")
                        Spacer(minLength: 30)
                        Text("Seed:")
                        Divider()
                        SeedWordLayout(seedData: self.seedData, geometry: geometry, usePickSet: false)
                        Divider()
                    }
                    VStack(alignment: .leading) {
                        Spacer(minLength: 30)
                        Text("Choose the next word in the seed:")
                        Divider()
                        SeedWordLayout(seedData: self.seedData, geometry: geometry, usePickSet: true)
                        Divider()
                        Spacer(minLength: 30)
                        HStack(alignment: .center) {
                            RemoveWordLayout(seedData: self.seedData)
                            Spacer(minLength: 20)
                            Button(action: {
                                
                            }) {
                                Text("Next")
                                    .padding(.all, 5)
                                    .font(.body)
                                    .background(Color("LightGreen"))
                                    .foregroundColor(Color.black)
                                    .cornerRadius(5)
                            }
                        }.padding(20)
                    }
                }
            }
        }
    }
}

struct SeedVerify_Previews: PreviewProvider {
    static var previews: some View {
        // SeedVerify()
        let seedData = SeedData(seed: ["one", "two", "three", "four", "five", "six", "do", "re", "mi", "fa", "so", "la"])
        return SeedVerify().environmentObject(seedData)
    }
}

struct SeedWordLayout: View {
    var seedData: SeedData
    let geometry: GeometryProxy
    let usePickSet: Bool
    
    /* init(seedData: SeedData) {
        self.seedData = SeedData(seedData: seedData)
    } */
    
    var body: some View {
        // print(seedData.pickSet)
        // print(seedData.guessedSeed)
        if (usePickSet) {
            return self.generateContent(in: geometry, tags: Array(seedData.pickSet))
        }
        else {
            return self.generateContent(in: geometry, tags: seedData.guessedSeed)
        }
    }

    private func generateContent(in g: GeometryProxy, tags: [String]) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.self) { tag in
                self.item(tag: tag)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == tags.last! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
    
    func item(tag: String) -> some View {
        Button(action: {
            self.seedData.pickWord(tag: tag)
        }) {
            Text(tag)
                .padding(.all, 5)
                .font(.body)
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(5)
        }
    }
}


struct RemoveWordLayout: View {
    var seedData: SeedData
    
    var body: some View {
        if let tag = seedData.guessedSeed.last {
            return self.removeButton(tag: tag, buttonOn: true)
        }
        else {
            return self.removeButton(tag: "", buttonOn: false)
        }
    }
    
    func removeButton(tag: String, buttonOn: Bool) -> some View {
        Button(action: {
            self.seedData.removeWord()
        }) {
            Text("Remove Word")
                .padding(.all, 5)
                .font(.body)
                .background(Color("LightGreen"))
                .foregroundColor(Color.black)
                .cornerRadius(5)
        }
        
        /* if (buttonOn) {
            return Button(action: {
                self.seedData.pickWord(tag: tag)
            }) {
                Text("Remove Word")
                    .padding(.all, 5)
                    .font(.body)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
            }
        }
        else {
            return Button(action: {
                self.seedData.pickWord(tag: "")
            }) {
                Text("Remove Word")
                    .padding(.all, 5)
                    .font(.body)
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
            }
        } */
    }
}
