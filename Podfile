workspace 'AppEstudoWorkspace'
platform :ios, '16.4'
use_frameworks!

target 'app-estudo' do
  project 'app-estudo/app-estudo.project'
  
  target 'app-estudoUITests' do
    inherit! :complete
  end
end

target 'UI' do
  project 'UI/UI.project'

  target 'UITests' do
    inherit! :complete
  end
end

target 'API' do
  project 'API/API.project'

  target 'APITests' do
    inherit! :complete
  end
end
