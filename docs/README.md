Despliegue de Jenkins personalizado con pipeline multibranch para PyInstaller
Este proyecto muestra cómo configurar Jenkins dentro de un contenedor Docker, personalizado para incluir Docker y Python, con el objetivo de ejecutar un pipeline definido mediante un Jenkinsfile. El pipeline se encarga de compilar una aplicación Python utilizando PyInstaller. Toda la ejecución se realiza desde la rama master.

Requisitos previos
Antes de comenzar, asegúrate de tener instalado en tu equipo:

Docker

Git

Pasos para ejecutar Jenkins
Clonar este repositorio

git clone https://github.com/zusrico/simple-python-pyinstaller-app.git
cd simple-python-pyinstaller-app

Construir la imagen personalizada de Jenkins

docker build -t jenkins_custom -f docs/Dockerfile .

Ejecutar Jenkins

docker run -d --name jenkins-test -p 8080:8080 --privileged jenkins_custom

Obtener contraseña de administrador

docker exec -it jenkins-test cat /var/jenkins_home/secrets/initialAdminPassword

Acceder a Jenkins en el navegador

Abre http://localhost:8080, pega la contraseña anterior y completa la instalación con los plugins sugeridos.

Crear pipeline multibranch

Crear una tarea nueva de tipo Multibranch Pipeline.

En “Branch Sources”, añadir:

Git

URL del repo: https://github.com/zusrico/simple-python-pyinstaller-app.git

Credenciales de GitHub si se requieren.

En “Discover branches”, usar Filter by name con master.

Guardar.

Qué hace el pipeline
El Jenkinsfile define 3 etapas:

Instalar dependencias: crea un entorno virtual e instala PyInstaller desde requirements.txt.

Test: ejecuta los tests con unittest.

Build: compila sources/main.py en un ejecutable con PyInstaller.

Estructura esperada del proyecto
.
├── docs/
│ ├── Dockerfile
│ └── README.md
├── jenkins/
├── sources/
│ └── main.py
├── Jenkinsfile
├── requirements.txt
└── ...

Salida esperada
El ejecutable se genera en:

workspace/python-app-pipeline_master/dist/

y puede descargarse desde el workspace de Jenkins.

Autores
Nombre: García Sánchez, Jesús y Abuín Sánchez, David.
Curso: Despliegue Python con Jenkins y Terraform
Fecha: Mayo 2025