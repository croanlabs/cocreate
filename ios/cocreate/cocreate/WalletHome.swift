//
//  CategoryHome.swift
//  cocreate
//
//  Created by Erza Salat on 11/07/2020.
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

struct WalletHome: View {
     @EnvironmentObject var seedData: SeedData
    
    var subviews = [
        UIHostingController(rootView: WalletHomeButtons()),
        UIHostingController(rootView: WalletSeedChoiceButtons())
    ]
    
    @State var currentPageIndex = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            WalletPageViewController(currentPageIndex: $currentPageIndex, viewControllers: subviews)
                .frame(height: 450)
        }
    }
}

struct WalletHomeButtons: View {
    // var seedData: SeedData
    
    var body: some View {
        VStack {
            Button(action: {
                
            }) {
                Text("I'm ready to get to work. Let's create a wallet.")
                    .padding(.all, 10)
                    .font(.body)
                    .background(Color("LightGreen"))
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
            }.padding(10)
        
            Button(action: {
           
            }) {
                Text("Explore the app first.")
                    .padding(.all, 10)
                    .font(.body)
                    .background(Color("LightGreen"))
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
            }.padding(40)
        }
    }
}

struct WalletSeedChoiceButtons: View {
    // var seedData: SeedData
    
    var body: some View {
        VStack {
            Button(action: {
                
            }) {
                Text("I have an existing wallet. Click here to enter seed.")
                    .padding(.all, 10)
                    .font(.body)
                    .background(Color("LightGreen"))
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
            }.padding(10)
        
            Button(action: {
                
            }) {
                Text("I want to create a new wallet.")
                    .padding(.all, 10)
                    .font(.body)
                    .background(Color("LightGreen"))
                    .foregroundColor(Color.black)
                    .cornerRadius(5)
            }.padding(40)
        }
    }
}

struct WalletHome_Previews: PreviewProvider {
    static var previews: some View {
        WalletHome()
        // WalletHome().environmentObject(seedData)
    }
}
