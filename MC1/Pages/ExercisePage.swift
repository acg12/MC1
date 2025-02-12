//
//  ExercisePage.swift
//  MC1
//
//  Created by Daniel Widjaja on 20/04/23.
//

import SwiftUI
import SwiftUIPager

struct ExercisePage: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var exerciseVM: ExerciseViewModel
    @EnvironmentObject var subtitleVM: SubtitleViewModel
    
    @StateObject var bannerVM = BannerViewModel()
    
    @State var currIndex = 0
    @State var indexes = [1, 2, 0, 1, 2]
    @State var scrollDirection = "none"
    @State var isDragging = false
    @State var itemCount = 0
    
    @State var quote = Quote(text: "before", author: "tes")
    
    @State var hour = Calendar.current.component(.hour, from: Date())

//    init() {
//        quote = bannerVM.getRandomQuotes()
//    }
    
    var body: some View {
        ZStack {
            VStack (alignment: .leading, spacing: 50) {
                VStack(alignment: .leading) {
                    
                    if hour >= 5 && hour < 12 {
                        Text("Good Morning, \(userVM.user.name)! 🌻")
                            .font(.title2)
                            .fontWeight(.bold)
                    }else if hour >= 12  && hour < 17 {
                        Text("Good Afternoon, \(userVM.user.name)! ☀️")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    else if hour >= 17  && hour < 21 {
                        Text("Good Evening, \(userVM.user.name)! 🌇")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    else{
                        Text("Good Night, \(userVM.user.name)! 🌙")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
//                    if hour == 6{
//                        Text("Good Morning, \(userVM.user.name)! 🌻")
//                            .font(.title2)
//                            .fontWeight(.bold)
//                    }
//                    if hour == 6{
//                        Text("Good Morning, \(userVM.user.name)! 🌻")
//                            .font(.title2)
//                            .fontWeight(.bold)
                    
                    
                    
                    // Banner
                    VStack(alignment: .leading){
                        HStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(
                                    Color(red: 17/255, green: 118/255, blue: 106/255)
                                )
                                .frame(width: 5)
             
                            
                            VStack(alignment: .leading) {
//                                let quote = bannerVM.getRandomQuotes()
                                //                            Text("Message of the day ✨")
                                //                                .font(.system(size: 14))
                                     
                                Text(quote.text)
                                    .frame(width:279,alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                      
                                Spacer()
                                Text("- \(quote.author)")
                                    .font(.system(size: 14))
                                
                            }
                            //                        .padding(EdgeInsets(top: 20, leading: 5, bottom: 5, trailing: 20))
                            .padding(.top,20)
                            .padding(.bottom,20)
//                            .padding(.trailing,60)
                            .onAppear {
                                if self.quote.text == "\"" + "before" + "\"" {
                                    self.quote = bannerVM.getRandomQuotes()
                                }
                                
                            }
                            
                            
                            //                        Image(systemName: "arrow.clockwise")
                            //                            .padding()
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 150)
                    .background(
                        Color(red: 17/255, green: 118/255, blue: 106/255)
                            .opacity(0.05)
                    )
                    .cornerRadius(5)
                    .padding(.trailing, 16)
                }
                
                VStack(alignment: .leading) {
                    Text("Choose Focus Exercise")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    GeometryReader { geometry in
                        HStack(spacing: 30) {
                            ForEach(indexes, id: \.self) { idx in
                                Button {
                                    router.path.append(exerciseVM.exercises[idx])
                                } label: {
                                    ExerciseCard(exercise: exerciseVM.exercises[idx])
                                }
                                .simultaneousGesture(DragGesture()
                                    .onChanged({ _ in
                                        self.isDragging = true
                                    })
                                    .onEnded({ _ in
                                        self.isDragging = false
                                    })
                                )
                                .disabled(self.isDragging)
                            }
                        }
                        .frame(width: geometry.size.width, alignment: .center)
                        .modifier(HStackScrollingModifier(items: exerciseVM.exercises.count, itemWidth: 189, itemSpacing: 30, index: $currIndex, direction: $scrollDirection, isDragging: $isDragging))
                    }
                    .onChange(of: currIndex) { _ in
                        // scroll ke kiri
                        if scrollDirection == "left" {
                            if indexes.first! == 2 {
                                indexes.insert(1, at: 0)
                            } else if indexes.first! == 1 {
                                indexes.insert(0, at: 0)
                            } else {
                                indexes.insert(2, at: 0)
                            }
                        } else if scrollDirection == "right" {
                            if indexes.last! == 2 {
                                indexes.append(0)
                            } else if indexes.last! == 1 {
                                indexes.append(2)
                            } else {
                                indexes.append(1)
                            }
                        }
                    }
                    .frame(height: 292)
                    
                    HStack {
                        if currIndex == 0 {
                            Circle()
                                .foregroundColor(Color(red: 17/255, green: 118/255, blue: 106/255))
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .frame(width: 8, height: 8)
                        }
                        
                        if currIndex == 1 {
                            Circle()
                                .foregroundColor(Color(red: 17/255, green: 118/255, blue: 106/255))
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .frame(width: 8, height: 8)
                        }
                        
                        if currIndex == 2 {
                            Circle()
                                .foregroundColor(Color(red: 17/255, green: 118/255, blue: 106/255))
                                .frame(width: 10, height: 10)
                        } else {
                            Circle()
                                .foregroundColor(Color(red: 217/255, green: 217/255, blue: 217/255))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
            
            // overlay disini
            VStack {
                
            }
        }
        .onAppear {
            itemCount = indexes.count
        }
        .onChange(of: indexes.count) { newValue in
            itemCount = newValue
        }
    }
}

struct ExercisePage_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePage()
            .environmentObject(UserViewModel())
            .environmentObject(Router())
            .environmentObject(ExerciseViewModel())
            .environmentObject(SubtitleViewModel())
    }
}
