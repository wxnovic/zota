//
//  IntroView.swift
//  zota
//
//  Created by Chu on 4/22/25.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        GeometryReader{ geometry in
        let width:CGFloat = CGFloat(geometry.size.width)
        let height:CGFloat = CGFloat(geometry.size.height)
            
        
            ZStack(){
                Image("background")
                    .resizable()
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
                Image("cloud")
                    .position(x: width * 0.9, y: height * 0.95)
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
                            // 컴포넌트 작성 필요
                            ZStack(){
                                Rectangle()
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(Color.init(hex: "DDDDDD"))
                                    .background(Color.gray)
                                Text("레이아웃")
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                            // 컴포넌트 작성 필요
                            ZStack(){
                                Rectangle()
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(Color.init(hex: "DDDDDD"))
                                    .background(Color.gray)
                                Text("레이아웃")
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
              
                            
                        }
                        HStack(){
                            // 컴포넌트 작성 필요
                            ZStack(){
                                Rectangle()
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(Color.init(hex: "DDDDDD"))
                                    .background(Color.gray)
                                Text("레이아웃")
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                            // 컴포넌트 작성 필요
                            ZStack(){
                                Rectangle()
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(Color.init(hex: "DDDDDD"))
                                    .background(Color.gray)
                                Text("레이아웃")
                                    .frame(width: 100, height: 120)
                                    .foregroundColor(.black)
                                    .font(.title3)
                            }
                        }
                    }
                    .frame(width: 300, height: 300)
                    .background(Color.gray.opacity(0.8), in : RoundedRectangle(cornerRadius: 25))

                }
                .position(x: width / 2, y: height / 2)

                
                
            }.onTapGesture {
                print(width)
                print(height)
            }
            
        }
    }
}



#Preview {
    MainView()
}
