//
//  IntroView.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI

struct IntroView: View {

    var body: some View {
        GeometryReader{ geometry in
        let width:CGFloat = CGFloat(geometry.size.width)
        let height:CGFloat = CGFloat(geometry.size.height)
            
        
            ZStack(){
                Image("background")
                    .ignoresSafeArea()
                    .zIndex(-1)
                
                Image("sun")
                    .position(x: width * 0.3, y: height * 0.1)
                    .zIndex(1)
                Image("cloud")
                    .position(x: width * 0.15, y: height * 0.09)
                    .opacity(0.9)
                    .zIndex(2)
                Image("cloud")
                    .position(x: width * 0.8, y: height * 0.38)
                    .zIndex(0)
                Image("cloud")
                    .position(x: width * 0.15, y: height * 0.65)
                    .zIndex(0)
                
                VStack(){
                    ZStack(){
                        Image("bomb")
                            .resizable()
                            .frame(width: 300, height: 300)
                        Text("04 : 04")
                            .foregroundColor(.red).zIndex(1).font(.title)
                            .offset(x: 2, y: 16)
                    }
                    .padding()
                    .shadow(radius: 10)
                    .frame(width: 300, height: 250)
                    .border(.green, width: 5)
                
                    VStack(){
                        HStack(){
                            Text("04/22")
                                .font(.title)
                                .bold()
                            Text("Tue")
                                .foregroundColor(.green)
                                .font(.title)
                                .bold()
                        }
                    }
                    
                    VStack(){
                        HStack(){
                            
                        }
                    }
                    .frame(width: 300, height: 300)
                    .background(Color.gray, in : RoundedRectangle(cornerRadius: 25))
                    .opacity(0.3)
                    
                    
                        
                        
                    
                }
                .position(x: width / 2, y: height / 2)
                .border(Color.red, width: 5)
                
                
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
