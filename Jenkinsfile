node {
  stages {
    def image

    stage('Clean') {
        sh 'rm * -f -r -d -v'
    }

    stage('cloneRepository') {
        checkout scm
    }

    stage('buildImage') {
        image = docker.build("${env.registryName}/${env.imageName}:${env.BUILD_NUMBER}", ".")
    }

    stage('scanImage') {
        try {
            prismaCloudScanImage ca: '', cert: '', dockerAddress: 'unix:///var/run/docker.sock', ignoreImageBuildTime: true, image: "${env.registryName}/${env.imageName}:${env.BUILD_NUMBER}", key: '', logLevel: 'debug', podmanPath: '', project: '', resultsFile: 'prisma-cloud-scan-results.json'
        }
        finally {
            prismaCloudPublish resultsFilePattern: 'prisma-cloud-scan-results.json'
        }
    }
          
    stage('pushImage') {
            docker.withRegistry('') {
              image.push("${env.BUILD_NUMBER}")
            }
    }
  }

  post {
    always {
      sh "docker image rm ${env.registryName}/${env.imageName}:${env.BUILD_NUMBER}"
    }
  }
}
