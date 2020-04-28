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
                //   sh '/usr/bin/aws cloudformation describe-stacks'
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
                  sh '/usr/bin/aws --version'
                  sh '/usr/bin/aws --version'
                  withAWS(region:'eu-west-1',credentials:'aws-creds') {
                  sh 'echo "Uploading content with AWS creds"'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'udacity-jenkins-cicd')
                //   sh 'which aws'
                  sh '/usr/bin/aws --version'
                  sh 'echo "This is the step after the versioning"'    
                  sh '/usr/bin/aws cloudformation describe-stacks'
                  sh'''
                      echo "Conditional statement"
                      STATUS_PENDING=true
                      
                      while [ "$STATUS_PENDING" = "true" ] 
                      do
                        CurrStatus=$(/usr/bin/aws cloudformation describe-stacks --query "Stacks[0].StackStatus" --no-paginate --output text)
                        if [ "$CurrStatus" = "CREATE_IN_PROGRESS" ]; then
                          echo "Still running Cloudformation templates"
                          continue
                        elif [ "$CurrStatus" = "CREATE_FAILED" ]; then
                          echo "Cloudformation stack creation failed"
                          STATUS=false
                          exit 1
                        elif [ "$CurrStatus" = "CREATE_COMPLETE" ]; then
                          echo "Cloudformation template done"
                          STATUS_PENDING=false
                          
                        fi
                      done
                      exit 0

                  '''
                  }
              }
         }
     }
}
