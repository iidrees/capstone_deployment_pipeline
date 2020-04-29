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
                //   sh '/usr/local/bin/aws cloudformation describe-stacks'
                //   sh '/home/ubuntu/.local/bin/aws --version'
              }
         }
        //  stage('Security Scan') {
        //       steps { 
        //          aquaMicroscanner imageName: 'alpine:latest', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
        //       }
        //  }         
         stage('Cloudformation: VPC Stack') {
              steps {
                  sh '/usr/local/bin/aws --version'
                  sh '/usr/local/bin/aws --version'
                  withAWS(region:'eu-west-1',credentials:'aws-creds') {
                  sh 'echo "Uploading content with AWS creds"'
                  sh 'pwd'
                  sh '/usr/local/bin/aws cloudformation create-stack --stack-name k8s-jenkins-vpc --template-body file://cloudformation/vpc.yaml  --parameters file://cloudformation/parameters.json --on-failure DELETE &'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'udacity-jenkins-cicd')
                //   sh 'which aws'
                  sh '/usr/local/bin/aws --version'
                  sh 'echo "This is the step after the versioning"'    
                  sh '/usr/local/bin/aws cloudformation describe-stacks'
                  sh'''
                      echo "Conditional statement"
                      STATUS_PENDING=true
                      
                      while [ "$STATUS_PENDING" = "true" ] 
                      do
                        CurrStatus=$(/usr/local/bin/aws cloudformation describe-stacks --stack-name k8s-jenkins-vpc --query "Stacks[0].StackStatus" --no-paginate --output text)
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
         stage('Cloudformation: K8s Cluster Stack') {
              steps {
                  sh '/usr/local/bin/aws --version'
                  sh '/usr/local/bin/aws --version'
                  withAWS(region:'eu-west-1',credentials:'aws-creds') {
                  sh 'echo "Uploading content with AWS creds"'
                  sh 'pwd'
                  sh '/usr/local/bin/aws cloudformation create-stack --stack-name k8s-cluster --template-body file://cloudformation/cluster.yaml  --on-failure DELETE &'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'udacity-jenkins-cicd')
                //   sh 'which aws'
                  sh '/usr/local/bin/aws --version'
                  sh 'echo "This is the step after the versioning"'    
                  sh '/usr/local/bin/aws cloudformation describe-stacks'
                  sh'''
                      echo "Conditional statement"
                      STATUS_PENDING=true
                      
                      while [ "$STATUS_PENDING" = "true" ] 
                      do
                        CurrStatus=$(/usr/local/bin/aws cloudformation describe-stacks --stack-name k8s-cluster --query "Stacks[0].StackStatus" --no-paginate --output text)
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
         stage('K8S-Production: Deploy Blue Env  ') {
              steps {
                //   sh '/usr/local/bin/aws --version'
                //   sh '/usr/local/bin/aws --version'
                  withAWS(region:'eu-west-1',credentials:'aws-creds') {
                  sh 'echo "Uploading content with AWS creds"'
                  sh 'pwd'
                //   sh '/usr/local/bin/aws cloudformation create-stack --stack-name k8s-cluster --template-body file://cloudformation/cluster.yaml  --on-failure DELETE &'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'udacity-jenkins-cicd')
                //   sh 'which aws'
                  sh '/usr/local/bin/aws --version'
                  sh '''
                      echo "Connect to cluster"
                      /usr/local/bin/aws eks --region eu-west-1 update-kubeconfig --name prod-test
                  '''
                //   sh '/usr/local/bin/aws eks --region eu-west-1 update-kubeconfig --name prod-test'
                  sh'''
                      echo "Check version and then deploy to cluster"
                      kubectl version --client

                      echo "export the environment role"
                      
                      export TARGET_ROLE=blue

                      echo "replace the env_vars in the yaml file"
                      envsubst < ./k8s/deployment.yaml > deploy.yaml
                      envsubst < ./k8s/service.yaml > svc.yaml

                      echo "deploy to k8s"
                      kubectl apply -f deploy.yaml
                      kubectl apply -f svc.yaml

                      rm deploy.yaml
                      rm svc.yaml
                  '''
                  }
              }
         }
         stage('K8S-Production: Deploy Green Env  ') {
              steps {
                //   sh '/usr/local/bin/aws --version'
                //   sh '/usr/local/bin/aws --version'
                  withAWS(region:'eu-west-1',credentials:'aws-creds') {
                  sh 'echo "Uploading content with AWS creds"'
                  sh 'pwd'
                //   sh '/usr/local/bin/aws cloudformation create-stack --stack-name k8s-cluster --template-body file://cloudformation/cluster.yaml  --on-failure DELETE &'
                    //   s3Upload(pathStyleAccessEnabled: true, payloadSigningEnabled: true, file:'index.html', bucket:'udacity-jenkins-cicd')
                //   sh 'which aws'
                  sh '/usr/local/bin/aws --version'
                  sh '''
                      echo "Connect to cluster"
                      /usr/local/bin/aws eks --region eu-west-1 update-kubeconfig --name prod-test
                  '''
                //   sh '/usr/local/bin/aws eks --region eu-west-1 update-kubeconfig --name prod-test'
                  sh'''
                      echo "Check version and then deploy to cluster"
                      export TARGET_ROLE=green

                      envsubst < ./k8s/deployment.yaml > deploy.yaml
                      envsubst < ./k8s/service.yaml > svc.yaml
                      kubectl apply -f deploy.yaml
                      kubectl apply -f svc.yaml

                      rm deploy.yaml
                      rm svc.yaml
                  '''
                  }
              }
         }
     }
}
