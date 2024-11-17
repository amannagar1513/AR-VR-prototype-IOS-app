import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            DriveModeView()
                .tabItem {
                    Label("Drive Mode", systemImage: "car.fill")
                }

            GameModeView()
                .tabItem {
                    Label("Game Mode", systemImage: "gamecontroller.fill")
                }
        }
        .ignoresSafeArea()
    }
}

struct HomeView: View {
    @State private var currentTime = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                   
                    // Title
                    Text("ARVR CONNECT")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal)

                    // Car Image
                    Image("car_image")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .padding(.horizontal)

                    // Speedometer
                    HStack {
                        Spacer()
                        VStack {
                            Text("0 Kmph")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Last Updated: \(currentTime)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            currentTime = Date().formatted(date: .omitted, time: .shortened)
                        }
                    }

                    // Location and Fuel
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Faridabad Bypass,")
                                .foregroundColor(.white)
                            Text("Indraprastha Colony")
                                .foregroundColor(.white)
                            Text("Faridabad")
                                .foregroundColor(.white)

                            Button("Locate My Car>") {
                                // Action to locate car
                            }
                            .foregroundColor(.orange)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            Image(systemName: "house.fill")
                                .foregroundColor(.orange)
                            Text("264 kms")
                                .foregroundColor(.white)

                            Button("Fuel Diary >") {
                                // Action for fuel diary
                            }
                            .foregroundColor(.orange)
                        }
                    }
                    .padding()

                    // Last Trip
                    VStack(alignment: .leading) {
                        Text("Last Trip")
                            .font(.headline)
                            .foregroundColor(.white)
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.orange)
                            VStack(alignment: .leading) {
                                Text("Rajiv Enclave")
                                    .foregroundColor(.white)
                                Text("16 Nov 2024, 14:43")
                                    .foregroundColor(.gray)
                            }
                        }
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.orange)
                            VStack(alignment: .leading) {
                                Text("Indraprastha Colony")
                                    .foregroundColor(.white)
                                Text("16 Nov 2024, 14:06")
                                    .foregroundColor(.gray)
                            }
                        }
                        Button("Trip Summary >") {
                            // Action for trip summary
                        }
                        .foregroundColor(.orange)
                    }
                    .padding()
                }
                .background(Color(red: 0.12, green: 0.13, blue: 0.15))
                .ignoresSafeArea()
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct GameModeView: View {
    @State private var isGameModeOn = false
    @State private var showConfirmation = false
    @State private var selectedSurrounding = "Desert"
    @State private var isPlayGameOn = false
    @State private var selectedGame: String = "Asphalt 9"

    let surroundings = ["Desert", "Rainforest", "Snow"]
    let racingGames = ["Asphalt 9", "Real Racing 3", "Need for Speed No Limits"]

    var body: some View {
        VStack {
            ZStack {
                Color(red: 0.12, green: 0.13, blue: 0.15)
                    .ignoresSafeArea()

                Image(systemName: "power.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(isGameModeOn ? .green : .orange)

                Image(systemName: "gamecontroller.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .offset(x: 15, y: 15)
            }
            .onTapGesture {
                if isGameModeOn {
                    isGameModeOn = false
                } else {
                    showConfirmation = true
                }
            }
            .confirmationDialog(
                "Confirmation",
                isPresented: $showConfirmation
            ) {
                Button("Yes") {
                    isGameModeOn = true
                }
                Button("No", role: .cancel) {
                    isGameModeOn = false
                }
            } message: {
                Text("Ignition will be turned OFF")
            }
            .padding(.top)

            Spacer()

            if isGameModeOn {
                VStack(alignment: .leading) {
                    Text("Choose your Surrounding")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.bottom, 5)

                    Picker("Surrounding", selection: $selectedSurrounding) {
                        ForEach(surroundings, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.bottom)

                    Toggle("Play Game", isOn: $isPlayGameOn)
                        .foregroundColor(.black)
                        .padding(.bottom, 5)

                    if isPlayGameOn {
                        
                        VStack {
                            Text("Select Game")
                                .foregroundColor(.white)
                                .padding(.bottom, 5)

                            Picker("Select Game", selection: $selectedGame) {
                                ForEach(racingGames, id: \.self) { game in
                                    Text(game)
                                        .foregroundColor(.black)
                                }
                            }
                            .pickerStyle(.wheel)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                            )
                            .frame(height: 150) // Add a frame to ensure it fits well
                            .padding(.bottom)
                        }
                    }
                }
                .padding()
                
            }
            
        }
        
        .onChange(of: isGameModeOn) { _, newValue in
                   if !newValue {
                       selectedSurrounding = "Desert"
                       isPlayGameOn = false
                       selectedGame = "Asphalt 9" // Reset selected game to default
                   }
               }
        
    }
}

struct DriveModeView: View {
    @State private var isDriveModeOn = false
    @State private var showConfirmation = false
    @State private var isCarDoorLocked = false
    @State private var isNavigationOn = false
    @State private var isCameraAccessOn = false
    @State private var isDrivingAssistanceOn = false
    @State private var isSoundHapticOn = false
    var body: some View {
           ZStack { // Add ZStack here
               Color(red: 0.12, green: 0.13, blue: 0.15)
                  //.ignoresSafeArea()

               VStack {
                   
                   Spacer()
                   Image(systemName: isDriveModeOn ? "power.circle.fill" : "power.circle")
                       .font(.system(size: 100))
                       .foregroundColor(isDriveModeOn ? .green : .orange)
                       .onTapGesture {
                           isDriveModeOn.toggle()
                          
                       }
                      // .padding()

                   Spacer()

                   if isDriveModeOn {
                       VStack(alignment: .leading) {
                           Toggle("Car Door Lock/Unlock", isOn: $isCarDoorLocked)
                               .foregroundColor(.white)
                           Toggle("Navigation", isOn: $isNavigationOn)
                               .foregroundColor(.white)
                           Toggle("Camera Access", isOn: $isCameraAccessOn)
                               .foregroundColor(.white)
                           Toggle("Driving Assistance", isOn: $isDrivingAssistanceOn)
                               .foregroundColor(.white)
                           Toggle("Sound/Haptic", isOn: $isSoundHapticOn)
                               .foregroundColor(.white)
                       }
                       
                    .padding()
                   }
               }
           }
           .onChange(of: isDriveModeOn) { _, newValue in
               if !newValue {
                   isCarDoorLocked = false
                   isNavigationOn = false
                   isCameraAccessOn = false
                   isDrivingAssistanceOn = false
                   isSoundHapticOn = false
               }
           }
       }
}

        

       
