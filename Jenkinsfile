pipeline {
     agent any
     stages {
         stage('Build') {
             steps {
                 sh 'echo "Hello World"'
                 sh '''
                     echo "Multiline shell steps works too"
                     ls -lah
                     echo "Install Tidy linting package in the instance"
                     
                 '''
             }
         }
         stage('Lint HTML') {
              steps {
                //   sh 'tidy -q -e *.html'
                  sh 'docker version'
                  sh 'kubectl version --client'
                  sh 'pythons -m awscli --version'
                //   sh '/home/ubuntu/.local/bin/aws --version'
              }
         }
        //  stage('Security Scan') {
        //       steps { 
        //          aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
        //       }
        //  }         
         stage('Upload to AWS / Test the aws config') {
              steps {
                  sh '/home/ubuntu/.local/bin/aws --version'
                  sh 'aws --version'
                  withAWS(region:'eu-west-1',credentials:'aws-creds') {
                  sh 'echo "Uploading content with AWS creds"'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'udacity-jenkins-cicd')
                //   sh 'which aws'
                  sh 'sudo /home/ubuntu/.local/bin/aws --version'
                  sh 'echo "This is the step after the versioning"'    
                  sh 'sudo /home/ubuntu/.local/bin/aws cloudformation --describe-stacks'
                  }
              }
         }
     }
}
