 * Docker image build pipeline
 IMAGE_NAME - sushanttickoo22/tomcat
 IMAGE_GIT_URL - https://github.com/sushanttickoo22/ft-java-webapp.git
 IMAGE_BRANCH - master
 IMAGE_CREDENTIALS_ID - sushanttickoo22
 IMAGE_TAGS - latest
 DOCKERFILE_PATH - Dockerfile
 REGISTRY_URL - https://hub.docker.com/repositories
 UPLOAD_TO_DOCKER_HUB    - True\False
 REGISTRY_CREDENTIALS_ID - sushanttickoo22
 
 

def common = new com.mirantis.mk.Common()
def gerrit = new com.mirantis.mk.Gerrit()
def git = new com.mirantis.mk.Git()
def dockerLib = new com.mirantis.mk.Docker()
def artifactory = new com.mirantis.mcp.MCPArtifactory()

slaveNode = env.Slave ?: 'docker'
uploadToDockerHub = env.UPLOAD_TO_DOCKER_HUB ?: True

timeout(time: 12, unit: 'HOURS') {
    node(slaveNode) {
        def workspace = common.getWorkspace()
        def imageTagsList = env.IMAGE_TAGS.tokenize(" ")
        try {

            def buildArgs = []
            try {
                buildArgs = IMAGE_BUILD_PARAMS.tokenize(' ')
            } catch (Throwable e) {
                buildArgs = []
            }
            def dockerApp
            stage("checkout") {
                git.checkoutGitRepository('.', IMAGE_GIT_URL, IMAGE_BRANCH, IMAGE_CREDENTIALS_ID)
            }

            if (IMAGE_BRANCH == "master") {
                try {
                    def tag = sh(script: "git describe --tags --abbrev=0", returnStdout: true).trim()
                    def revision = sh(script: "git describe --tags --abbrev=4 | grep -oP \"^${tag}-\\K.*\" | awk -F\\- '{print \$1}'", returnStdout: true).trim()
                    imageTagsList << tag
                    revision = revision ? revision : "0"
                    if (Integer.valueOf(revision) > 0) {
                        imageTagsList << "${tag}-${revision}"
                    }
                    if (!imageTagsList.contains("latest")) {
                        imageTagsList << "latest"
                    }
                } catch (Exception e) {
                    common.infoMsg("Impossible to find any tag")
                }
            }

            stage("build") {
                common.infoMsg("Building docker image ${IMAGE_NAME}")
                dockerApp = dockerLib.buildDockerImage(IMAGE_NAME, "", "${workspace}/${DOCKERFILE_PATH}", imageTagsList[0], buildArgs)
                if (!dockerApp) {
                    throw new Exception("Docker build image failed")
                }
            }
            stage("upload to docker hub") {
                if (uploadToDockerHub) {
                    docker.withRegistry(REGISTRY_URL, REGISTRY_CREDENTIALS_ID) {
                        for (int i = 0; i < imageTagsList.size(); i++) {
                            common.infoMsg("Uploading image ${IMAGE_NAME} with tag ${imageTagsList[i]} to dockerhub")
                            dockerApp.push(imageTagsList[i])
                        }
                    }
                } else {
                    common.infoMsg('upload to docker hub skipped')
                }
            }
        }    
    }
}
