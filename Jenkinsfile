pipeline {

 agent any

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }
       parameters {
        string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }

    stage('TF Plan') {
      steps {
          
          sh 'PATH=/usr/local/bin'
          sh 'terraform init' //only need for first run 
          sh 'sudo terraform refresh -lock=false'
          sh 'cp ../terraform.tfvars .'
          sh 'ls'
          sh 'sudo terraform plan  -lock=false -out oke_plan'
      }      
    }

    stage('Approval') {
      steps {
        script {
          def userInput = input(id: 'confirm', message: 'Apply Terraform?', parameters: [ [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Apply terraform', name: 'confirm'] ])
        }
      }
    }

    stage('TF Apply') {
      steps {
          sh 'sudo terraform apply -lock=false -input=false oke_plan'
      }
    }

  } 

}
