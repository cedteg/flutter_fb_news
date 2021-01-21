pipeline {
    agent {
        label 'mac'
    }
    stages {
        stage('FLUTTER VERSION') {
           steps {
              script {
                 sh 'git --git-dir=$FLUTTER_DIR.git --work-tree=$FLUTTER_DIR stash'
                 sh 'git --git-dir=$FLUTTER_DIR.git --work-tree=$FLUTTER_DIR checkout $CUSTOM_FLUTTER_VERSION'
                 if ( CUSTOM_FLUTTER_VERSION == 'beta' ) { 
                    sh 'flutter upgrade' 
                 }
              }
           }
        }
        stage('PUB') {
            steps {
                sh 'flutter pub get'
                sh 'flutter pub upgrade'
            }
        }
        stage('ANALYZE') {
            steps {
                sh 'flutter analyze'
            }
        }
        stage('TEST') {
            steps {
                sh 'flutter test'
            }
        }
    }

}
