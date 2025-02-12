//
//  ExerciseDetailView.swift
//  MC1
//
//  Created by Daniel Widjaja on 20/04/23.
//

import SwiftUI

struct ExerciseDetailView: View {
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var router: Router
    @EnvironmentObject var exerciseVM: ExerciseViewModel
    @EnvironmentObject var subtitleVM: SubtitleViewModel
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var showModal = false
    var exercise: ExerciseModel
    
    var body: some View {
        VStack (alignment: .leading) {
            Spacer(minLength: 0)
                            .navigationBarBackButtonHidden(true)
                            .toolbar(content:{
                                ToolbarItem(placement: .navigationBarLeading){
                                    Button(action: {
                                        presentationMode.wrappedValue.dismiss()
                                    }, label: {
                                        Image(systemName: "chevron.left")
                                            .foregroundColor(.white)
                                        Text("Focus")
                                            .foregroundColor(.white)
                                            .fontWeight(.regular)
                                            .font(.system(size: 17))
                                    })
                                }
                            })
            VStack{
                Image(exercise.bg)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(alignment: .leading){
                Text(exercise.tagLine)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                    .padding(.bottom,15)
                
                
                HStack {
                    HStack{
                        Image(systemName: "waveform")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(red: 0.066, green: 0.463, blue: 0.415))
                        
                        Text(exercise.name)
                            .fontWeight(.regular)
                            .font(.system(size: 17))
                            .foregroundColor(Color(red: 0.3333333333333333, green: 0.3333333333333333, blue: 0.3333333333333333))
                    }
                    .padding(.trailing,20)
                    HStack{
                        Image(systemName: "timer")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color(red: 0.066, green: 0.463, blue: 0.415))
                        
                        Text(exercise.duration)
                            .fontWeight(.regular)
                            .font(.system(size: 17))
                            .foregroundColor(Color(red: 0.3333333333333333, green: 0.3333333333333333, blue: 0.3333333333333333))
                    }
                }
                .padding(.bottom,15)
                
                
                Text(exercise.desc)
                    .fontWeight(.regular)
                    .frame(width: 326, height: 72)
                    .font(.system(size: 15))
                
                
                
            }
            .padding(.leading,20)
            .padding()
            
            
            NavigationLink(value: "requirement") {
                Text("Start")
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(red: 0.066, green: 0.463, blue: 0.415))
                    .cornerRadius(10)
                //            }
                    .padding(.bottom,20)
                    .padding(30)
                    .onTapGesture {
                        showModal.toggle()
                    }
                    .sheet(isPresented: $showModal, content:{
                        ExerciseRequirementView()
                            .environmentObject(router)
                            .environmentObject(exerciseVM)
                            .environmentObject(subtitleVM)
                    })
                
            }
            .onAppear {
                exerciseVM.currentEx = exercise
            }
        }
    }
}

struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exercise: ExerciseModel(id: 1, name: "3 Minutes Breath", duration: "3:27", desc: "Using mindfulness of breathing for short periods at set times and when required. Best for dealing with mind wandering, and learning to be gentle with yourself.", requirement: ["Airpods or a conducive place", "A safe place for sit or lay down", "Turn on focus mode or do not disturb"], icon: "icon3MB", backgroundURL: "Cards/3MB", bg: "bg3MB", audioDuration: 207, audioName: "3MB Audio", tagLine: "In a Hurry"))
            .environmentObject(Router())
            .environmentObject(UserViewModel())
            .environmentObject(ExerciseViewModel())
            .environmentObject(SubtitleViewModel())
    }
}
