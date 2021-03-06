//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: space.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

final class SeedData: ObservableObject  {
    
    @Published var actualSeed = [String]()
    @Published var guessedSeed = [String]()
    @Published var seedSet = Set<String>()
    @Published var pickSet = Set<String>()
    
    init () {}
    
    init(seedData: SeedData) {
        self.actualSeed = seedData.actualSeed
        self.guessedSeed = seedData.guessedSeed
        self.seedSet = seedData.seedSet
        self.pickSet = seedData.pickSet
    }
    
    init (seed: [String]) {
        self.actualSeed += seed
        self.actualSeed.forEach{ str in seedSet.insert(str) }
        pickSix()
        // print(actualSeed)
        // print(pickSet)
    }
    
    
    func pickSix() {
        var count = 5
        var removedNextWord = false
        pickSet.removeAll()
        // print("guessed: ", guessedSeed)
        let nextWord = actualSeed[guessedSeed.count]
        if guessedSeed.contains(nextWord) {
            if let str = self.seedSet.randomElement() {
                self.pickSet.insert(str)
            }
        }
        else {
            pickSet.insert(nextWord)
            seedSet.remove(nextWord) // don't show nextWord twice
            removedNextWord = true
        }
        
        while count > 0 {
            if let str = self.seedSet.randomElement() {
                self.seedSet.remove(str)
                self.pickSet.insert(str)
                count -= 1
            }
            else {
                break
            }
        }
        if (removedNextWord) { // put word back in seedSet
            seedSet.insert(nextWord)
        }
    }
    
    func pickWord(tag: String) {
        if (tag == "") { return }
        self.pickSet.remove(tag)
        self.seedSet.remove(tag)
        self.guessedSeed.append(tag)
        print("before seed: ", seedSet)
        self.seedSet.formUnion(pickSet)
        print("after seed: ", seedSet)
        if (!seedSet.isEmpty) {
            pickSix()
        }
    }
    
    func removeWord() {
        if let str = guessedSeed.last {
            self.seedSet.insert(str)
            self.seedSet.formUnion(pickSet)
            self.guessedSeed.removeLast()
            pickSix()
        }
    }
}
