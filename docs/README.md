# Despliegue de Jenkins personalizado con pipeline multibranch para PyInstaller

Este proyecto demuestra cómo desplegar una infraestructura DevOps completa utilizando Docker y Terraform. El objetivo es ejecutar una pipeline en Jenkins que compile una aplicación Python con PyInstaller, de forma automatizada desde el código fuente de GitHub.

## Requisitos previos

Antes de comenzar, asegúrate de tener instalado:

- Docker (y que el demonio esté corriendo)
- Terraform
- Git
- Acceso a internet
- Linux (preferiblemente, por compatibilidad con Terraform + Docker)

## Estructura esperada del proyecto

```
.
├── docs/
│   ├── Dockerfile
│   ├── main.tf
│   ├── provider.tf
│   ├── outputs.tf
│   └── README.md
├── Jenkinsfile
├── requirements.txt
├── sources/
│   └── main.py
```

## Paso 1: Clonar este repositorio

```bash
git clone https://github.com/zusrico/simple-python-pyinstaller-app.git
cd simple-python-pyinstaller-app/docs
```

## Paso 2: Desplegar Jenkins con Terraform

### 2.1. Inicializar Terraform

```bash
terraform init
```

### 2.2. Aplicar el plan (construir imagen y lanzar contenedor)

```bash
terraform apply
```

Confirma escribiendo `yes` cuando te lo pida.

> Esto construirá la imagen `jenkins_custom` usando el `Dockerfile` y levantará un contenedor llamado `jenkins-from-tf` expuesto en el puerto 8080.

## Paso 3: Acceder a Jenkins

Abre tu navegador en:

```
http://localhost:8080
```

### 3.1. Obtener contraseña de administrador

```bash
docker exec -it jenkins-from-tf cat /var/jenkins_home/secrets/initialAdminPassword
```

Cópiala y pégala en la interfaz web de Jenkins.

### 3.2. Instalar plugins sugeridos

- Selecciona "Instalar plugins sugeridos"
- Espera a que termine la instalación

## Paso 4: Configurar el pipeline multibranch

1. En Jenkins, haz clic en **“New Item”**
2. Escribe un nombre, selecciona **Multibranch Pipeline**, y haz clic en OK
3. En **Branch Sources**, selecciona “Git”
4. Pega la URL del repositorio:  
   `https://github.com/zusrico/simple-python-pyinstaller-app.git`
5. Añade tus credenciales de GitHub si hace falta (token personal)
6. En “Discover branches”, asegúrate de detectar `master`
7. Guarda los cambios

> Jenkins escaneará la rama, detectará el `Jenkinsfile` y ejecutará automáticamente la pipeline.

## Qué hace el Jenkinsfile

El pipeline tiene 3 etapas:

1. **Instalar dependencias**  
   Crea un entorno virtual con `venv` e instala PyInstaller desde `requirements.txt`.

2. **Test**  
   Ejecuta los tests de `unittest` (aunque sean cero).

3. **Build**  
   Usa PyInstaller para compilar `sources/main.py` como binario ejecutable.

## Resultado esperado

Al finalizar correctamente el pipeline, se genera un ejecutable en:

```
workspace/python-app-pipeline_master/dist/main
```

Puedes descargarlo desde el workspace de Jenkins.

## Destruir la infraestructura (opcional)

Cuando termines, puedes eliminar todo con:

```bash
terraform destroy
```

Y confirmar con `yes`.

## Autores

García Sánchez, Jesús  
Abuín Sánchez, David

Fecha: Mayo 2025
