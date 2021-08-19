//
//  SwipeActions.swift
//  List&Row
//
//  Created by Akhmad Talatov on 18/08/21.
//

import SwiftUI


struct SecondView: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        
                        Rows(mainContent: {
                            Text("Athos")
                                .padding(16)
                        }, firstButtonAction: {
                            print("Athos: delete button")
                        }, secondButtonAction: {
                            print("Athos: share button")
                        }, firstBackColor: Color.red,
                        secondBackColor: Color.green,
                        firstImage: "trash",
                        secondImage: "square.and.arrow.up")
                        .frame(height: 60)
                        Divider()
                        Rows(mainContent: {
                            Text("Aramis")
                                .padding(16)
                        }, firstButtonAction: {
                            print("Aramis: pin button")
                        }, secondButtonAction: {
                            print("Aramis: more button")
                        }, firstBackColor: Color.yellow,
                        secondBackColor: Color.gray,
                        firstImage: "pin",
                        secondImage: "ellipsis")
                        .frame(height: 60)
                        Divider()
                        
                    }
                }
            }
        }
    }
}


struct Rows<Content: View> : View {
    
    @ViewBuilder var mainContent: Content
    var firstButtonAction: () -> Void
    var secondButtonAction: () -> Void
    
    var firstBackColor: Color
    var secondBackColor: Color
    
    var firstImage: String
    var secondImage: String
    
    @State var offset = CGSize.zero
    @State var supportingOffset: CGFloat = 0
    @State var offsetY: CGFloat = 0
    
    var body : some View {
        GeometryReader { geo in
            
            HStack (spacing : 0){
                mainContent
                    .frame(width : geo.size.width, alignment: .leading)
                
                ZStack {
                    Image(systemName: firstImage)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                .frame(width: 60, height: geo.size.height)
                .background(firstBackColor)
                .onTapGesture(perform: firstButtonAction)
                HStack {
                    Image(systemName: secondImage)
                        .padding(.trailing, geo.size.width - 40 - offsetY)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .trailing)
                .background(secondBackColor)
                .onTapGesture(perform: secondButtonAction)
            }
            .background(Color.white)
            .offset(self.offset)
            .animation(.spring())
            .gesture(DragGesture()
                        .onChanged { gestrue in
                            if self.supportingOffset == 0 {
                                self.offset.width = gestrue.translation.width
                            } else {
                                self.offset.width = gestrue.translation.width + self.supportingOffset
                            }
                            if self.offset.width < -120 && self.offset.width > -240{
                                self.offsetY = CGFloat(abs(offset.width) - 120)
                            }
                            else if self.offset.width < -240{
                                self.offsetY = 0
                            }
                        }
                        .onEnded { _ in
                            if self.offset.width < -50 && self.offset.width > -240 {
                                self.offset.width = -120
                                self.offsetY = 0
                            }
                            else if self.offset.width < -240 {
                                secondButtonAction()
                                self.offset.width = -0
                                self.offsetY = 0
                            }
                            else {
                                self.offset = .zero
                                self.offsetY = 0
                            }
                            self.supportingOffset = self.offset.width
                        }
            )
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
