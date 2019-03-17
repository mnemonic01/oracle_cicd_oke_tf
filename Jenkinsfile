pipeline {

  agent any

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        
      }
    }

    stage('TF Plan') {
      steps {
          
          sh 'terraform init'
          sh 'terraform plan -lock=false -out oke_plan'
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
          sh 'terraform apply -input=false oke_plan'
      }
    }

  } 

}
