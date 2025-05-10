resource "docker_image" "jenkins_custom" {
  name         = "jenkins_custom"
  build {
    path = "${path.module}/."  
  }
}


resource "docker_container" "jenkins" {
  name  = "jenkins-from-tf"
  image = docker_image.jenkins_custom.latest
  ports {
    internal = 8080
    external = 8080
  }
  privileged = true
}
