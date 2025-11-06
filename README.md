# Información del Curso

<table>
    <tbody>
        <tr>
            <td>Código del curso</td>
            <td>ST0263</td>
        </tr>
        <tr>
            <td>Nombre del curso</td>
            <td>Sistemas Distribuidos</td>
        </tr>
        <tr>
            <td>Estudiantes</td>
            <td>
                <ol>
                <li>Jerónimo Acosta Acevedo(<tt>jacostaa1[at]eafit.edu.co</tt>)</li>
                <li>Juan José Restrepo Higuita (<tt>jjrestre10[at]eafit.edu.co</tt>)</li>
                <li>Luis Miguel Torres Villegas (<tt>lmtorresv[at]eafit.edu.co</tt>)</li>
                </ol>
            </td>
        </tr>
        <tr>
            <td>Profesor</td>
            <td><a href="https://scholar.google.com/citations?user=BhCMq0oAAAAJ&hl=es">Edwin Nelson Montoya Múnera</a> (<tt>emontoya[at]eafit.edu.co</tt>)
        </tr>
    </tbody>
</table>



# Bookstore Deployment

## 1. Descripción
Este proyecto se centró en el diseño, despliegue y escalado de una aplicación web monolítica basada en Flask llamada Bookstore, migrándola progresivamente a entornos cloud-native y contenedorizados usando servicios de AWS y Kubernetes.

La actividad se dividió en cuatro objetivos principales, cada uno construyendo sobre el anterior para explorar distintos modelos de despliegue y componentes en la nube.

### 1.1. Requisitos completados
Objetivo 1 - Despliegue monolítico usando Docker

- Se desplegaron dos máquinas virtuales (VM).

    - VM 1: Alojó tanto el balanceador de carga Nginx como la aplicación Flask Bookstore usando Docker.

    - VM 2: Alojó un contenedor de base de datos MySQL.

- La configuración demostró aislamiento mediante contenedores y una sencilla red entre VMs para las capas de aplicación y datos.

Objetivo 2 - Infraestructura con autoescalado usando servicios AWS

- Se configuró un grupo de instancias con autoescalado para alta disponibilidad.

- Se usó RDS (Relational Database Service) para gestión de la base de datos, EFS (Elastic File System) para almacenamiento compartido entre instancias, y un ELB (Elastic Load Balancer) de Nginx para distribución de tráfico.

- Se montaron volúmenes EFS en instancias EC2 para persistencia de archivos en el entorno autoescalado.

Objetivo 3 - Despliegue en Kubernetes (EKS)

- Se desplegó la aplicación Flask Bookstore en Amazon EKS (Elastic Kubernetes Service).

- Se configuró MySQL dentro del clúster EKS para replicación y persistencia.

- Se definieron manifiestos de Kubernetes para servicios, despliegues y volúmenes persistentes.

Objetivo 4 - Despliegue de MySQL en EKS con alta disponibilidad

- Se reforzó y afinó el despliegue en EKS (Objetivo 3) como arquitectura final.

- El despliegue de MySQL fue replicado dentro del clúster para alta disponibilidad.

- Se validó la escalabilidad, persistencia de almacenamiento y accesibilidad del servicio vía el dominio dovakhinslayer.com.

### 1.2. Requisitos no cumplidos
- No se configuraron Elastic IPs; se usaron direcciones dinámicas y resolución DNS para pruebas.

- Implementación limitada de CI/CD; los despliegues se realizaron manualmente mediante la CLI y manifiestos.


## 2. Diseño de alto nivel
### Visión arquitectónica

1. Monolítico (Objetivo 1): Arquitectura con dos VMs donde Nginx + Flask corren en Docker y una instancia MySQL separada.

2. Autoescalado (Objetivo 2): Grupo de autoescalado en AWS con ELB, montajes EFS y RDS para persistencia de la BD.

3. EKS (Objetivo 3 y 4): Arquitectura basada en Kubernetes con múltiples pods para réplicas de la app Flask, despliegue de MySQL dentro del clúster y balanceo mediante Ingress/Servicio.

### Patrones de diseño

- Arquitectura en capas (presentación, lógica de negocio, datos).

- Modelo de despliegue basado en contenedores.

### Buenas prácticas aplicadas

- Contenerización con Docker para entornos consistentes.

- Uso de servicios gestionados de AWS (RDS, EFS, EKS) para escalabilidad y tolerancia a fallos.

- Acceso mediante DNS en lugar de IPs estáticas.


## 3. Entorno de desarrollo
- Lenguaje de programación: Python 3.11

- Framework: Flask

- Servidor web: Nginx

- Base de datos: MySQL/Aurora para RDS

- Contenerización: Docker

- Orquestación (etapas posteriores): Kubernetes (EKS)

- Control de versiones: Git / GitHub

### 3.1. Compilación y ejecución

# Clonar el repositorio
```
git clone https://github.com/luismtorresv/bookstore-deployment.git

cd bookstore-deployment

# Construir y ejecutar la app Flask
docker build -t bookstore-app .

docker run -d -p 5000:5000 bookstore-app
```

### 3.2. Detalles de desarrollo
- La aplicación Flask expone endpoints RESTful para la gestión de libros.

- Usa variables de entorno para credenciales de BD y configuración del host.

- Las tablas de MySQL se inicializan automáticamente al arrancar el contenedor.

### 3.3. Configuración
```
DB_HOST=<mysql_host>
DB_USER=<username>
DB_PASSWORD=<password>
DB_NAME=bookstore
FLASK_ENV=production
```


## 4. Entorno de ejecución (Producción)
- Proveedor Cloud: AWS
- Dominio: https://dovakhinslayer.com
- Infraestructura: Desplegado mediante EC2, RDS, EFS y EKS
- Base de datos: MySQL (RDS y/o versión contenarizada)

### 4.1. Infraestructura
Dominios cloud, IPs o nombres de host de servidores.

### 4.2. Configuración
La configuración se maneja mediante manifiestos de Kubernetes y ajustes en la consola de AWS (mount targets de EFS, endpoint de RDS y grupos de seguridad).

### 4.3. Despliegue
# Aplicar manifiestos de Kubernetes
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
```

### 4.4. Guía de usuario
1. Navegar a https://dovakhinslayer.com

2. Acceder a los endpoints API o a la UI de Bookstore para ver, añadir o modificar libros.

3. La persistencia de la base de datos y el escalado se gestionan automáticamente.
### 4.5. Resultados (Opcional)
- Despliegue exitoso de una aplicación Flask escalable y contenerizada accesible vía dominio.

- Validación del balanceo de carga y comportamiento de autoescalado.

- Verificación de la persistencia de almacenamiento entre instancias.


## 5. Información adicional
Notas relevantes sobre la actividad o el proyecto.

- El proyecto demuestra la evolución desde un despliegue monolítico hasta una infraestructura totalmente cloud-native y escalable.

- No se utilizaron Elastic IPs; la red se manejó mediante DNS interno de AWS y endpoints de load balancer.

- Se hizo énfasis en entender e integrar servicios de almacenamiento y orquestación de AWS.


## Referencias
- Amazon Web Services. (2025). Get started with Amazon EKS – eksctl.
  https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html

- Amazon Web Services. (2025). Push a Docker image to an Amazon ECR repository.
  https://docs.aws.amazon.com/AmazonECR/latest/userguide/docker-push-ecr-image.html

- Amazon Web Services. (2025). Private registry authentication in Amazon ECR.
  https://docs.aws.amazon.com/AmazonECR/latest/userguide/registry_auth.html

- Amazon Web Services. (2025). Use elastic file system storage with Amazon EFS
  (EKS). https://docs.aws.amazon.com/eks/latest/userguide/efs-csi.html

- Kubernetes. (2025, agosto 5). Persistent volumes.
  https://kubernetes.io/docs/concepts/storage/persistent-volumes/

- Kubernetes. (2025, septiembre 28). Service.
  https://kubernetes.io/docs/concepts/services-networking/service/

- Kubernetes. (2023, octubre 22). Create an external load balancer.
  https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/

- MySQL. (2025). 2.3.4 Setting up replication using GTIDs (MySQL 8.0 Reference
  Manual).
https://dev.mysql.com/doc/mysql-replication-excerpt/8.0/en/replication-gtids-howto.html

- MySQL. (2025). MySQL Replication (extracto del manual 8.0) [PDF].
  https://downloads.mysql.com/docs/mysql-replication-excerpt-8.0-en.pdf

- MySQL. (2025). Skipping transactions without GTIDs (MySQL 8.0 Reference
  Manual).
https://dev.mysql.com/doc/mysql-replication-excerpt/8.0/en/replication-administration-skip-nogtid.html

- Kubernetes SIGs. (2025). aws-efs-csi-driver [Repositorio GitHub].
  https://github.com/kubernetes-sigs/aws-efs-csi-driver

- Bitnami. (2025). mysql (Helm chart).
  https://artifacthub.io/packages/helm/bitnami/mysql
