//
//  IntroView.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI
import CoreData

struct IntroView: View {

    var body: some View {
        GeometryReader{ geometry in
        let width:CGFloat = CGFloat(geometry.size.width)
        let height:CGFloat = CGFloat(geometry.size.height)
            
        // 중앙
        let center = CGPoint(x: width / 2, y: height / 2)

        // 상단
        let topCenter = CGPoint(x: width / 2, y: 0)
        let topLeading = CGPoint(x: 0, y: 0)
        let topTrailing = CGPoint(x: width, y: 0)

        // 하단
        let bottomCenter = CGPoint(x: width / 2, y: height)
        let bottomLeading = CGPoint(x: 0, y: height)
        let bottomTrailing = CGPoint(x: width, y: height)

        // 좌우 중앙
        let leadingCenter = CGPoint(x: 0, y: height / 2)
        let trailingCenter = CGPoint(x: width, y: height / 2)
            
            ZStack(){
                Image("background").ignoresSafeArea().zIndex(-1)
                
                Image("sun").position(x: width * 0.3, y: height * 0.1).zIndex(1)
                Image("cloud").position(x: 0, y: 0).zIndex(0)
                Image("cloud").position(x: 0, y: 0).zIndex(0)
                Image("cloud").position(x: 0, y: 0).zIndex(0)
                
                VStack(){
                    ZStack(){
                        Image("bomb")
                            .frame(width: 200, height: 250)
                            .border(Color.green, width: 5)
                        Text("04 : 04").foregroundColor(.red).zIndex(1).font(.title).offset(x: 2, y: 16)
                    }
                }.position(x: 0, y: 0)
                
                VStack(){
                    HStack(){
                        Text("04/22")
                            .font(.title)
                        Text("Tue")
                            .foregroundColor(.green)
                            .font(.title)
                            .shadow(radius: 5)
                    }
                }
            }.onTapGesture {
                print(width)
                print(height)
            }
        }
    }
}



#Preview {
    IntroView()
}
