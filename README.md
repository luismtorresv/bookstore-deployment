# Course Information
- Course Code: ST0263-252 
- Course Name: Topicos Especiales en Telematica
- Student(s): Jeronimo Acosta, jacostaa1@eafit.edu.co
- Professor: <name>, <email-eafit>  

---

# Project Title / Lab / Activity

## 1. Description
This project focused on the design, deployment, and scaling of a Flask-based monolithic web application called Bookstore, progressively transitioning it into cloud-native and containerized environments using AWS services and Kubernetes.

The activity was divided into four main objectives, each building upon the previous one to explore various deployment models and cloud components.

### 1.1. Completed Requirements
Objective 1 - Monolithic Deployment using Docker

- Deployed two virtual machines (VMs).

    - VM 1: Hosted both the Nginx load balancer and the Flask Bookstore application using Docker.

    - VM 2: Hosted a MySQL database container.

- The setup demonstrated container-based isolation and simple inter-VM networking for application and data layers.

Objective 2 - Auto-Scaling Infrastructure with AWS Services

- Configured an auto-scaling instance group for high availability.

- Used RDS (Relational Database Service) for database management, EFS (Elastic File System) for shared storage across instances, and Nginx ELB (Elastic Load Balancer) for traffic distribution.

- Mounted EFS volumes to EC2 instances for file persistence across the auto-scaled environment.

Objective 3 - Kubernetes Deployment on EKS

- Deployed the Bookstore Flask application on Amazon EKS (Elastic Kubernetes Service).

- Configured MySQL inside the EKS cluster for database replication and persistence.

- Defined Kubernetes manifests for services, deployments, and persistent volumes.

Objective 4 - MySQL deployment on EKS cluster with High Availability

- Reinforced and refined the EKS deployment (Objective 3) as the final architecture choice.

- The SQL deployment was replicated inside the Cluster for high availability

- Validated scalability, storage persistence, and service accessibility via the domain dovakhinslayer.com. 

### 1.2. Unmet Requirements
- Elastic IPs were not configured, as dynamic IPs and DNS-based resolution were sufficient for testing.

- Limited implementation of CI/CD pipelines; deployments were done manually via CLI and manifests.  

---

## 2. High-Level Design
### Architecture Overview

1. Monolithic (Objective 1): Two VM-based architecture with Dockerized Nginx + Flask and a standalone MySQL instance.

2. Auto-Scaling (Objective 2): AWS Auto Scaling group with ELB, EFS mounts, and RDS integration for database persistence.

3. EKS (Objective 3 & 4): Kubernetes-based architecture with multiple pods for Flask app replicas, a MySQL deployment within the cluster, and load balancing via EKS ingress.

### Design Patterns

- Layered architecture (presentation, business, data).

- Container-based micro-deployment model.

### Best Practices Applied

- Docker containerization for consistent environments.

- Use of managed AWS services (RDS, EFS, EKS) for scalability and fault tolerance.

- DNS-based access instead of static IP allocation.

---

## 3. Development Environment
- Programming Language: Python 3.11

- Framework: Flask

- Web Server: Nginx

- Database: MySQL/Aurora for RDS

- Containerization: Docker

- Orchestration (later stages): Kubernetes (EKS)

- Version Control: Git / GitHub

### 3.1. Compilation and Execution

# Clone repository
```
git clone https://github.com/luismtorresv/bookstore-deployment.git

cd bookstore-deployment

# Build and run Flask app
docker build -t bookstore-app .

docker run -d -p 5000:5000 bookstore-app

```

### 3.2. Development Details
- Flask app exposes RESTful endpoints for managing books.

- Uses environment variables for DB credentials and host configuration.

- MySQL tables are initialized automatically on container start.

### 3.3. Configuration
```
DB_HOST=<mysql_host>
DB_USER=<username>
DB_PASSWORD=<password>
DB_NAME=bookstore
FLASK_ENV=production
```
---

## 4. Execution Environment (Production)
- Cloud Provider: AWS
- Domain: https://dovakhinslayer.com
- Infrastructure: Deployed through EC2, RDS, EFS, and EKS
- Database: MySQL (RDS and/or containerized version)

### 4.1. Infrastructure
Cloud domains, IPs, or server hostnames.  

### 4.2. Configuration
Configuration handled through Kubernetes manifests and AWS Console settings (EFS mount targets, RDS endpoint, and security groups).

### 4.3. Deployment
# Apply Kubernetes manifests
```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml

```

### 4.4. User Guide
1. Navigate to https://dovakhinslayer.com

2. Access the Bookstore API endpoints or UI to view, add, or modify book entries.

3. Database persistence and scaling are managed automatically.
### 4.5. Results (Optional)
- Successfully deployed a scalable, containerized Flask application accessible via domain.

- Validated load balancing and auto-scaling behaviors.

- Verified storage persistence across instances.

---

## 5. Additional Information
Other relevant notes about the activity or project. 

- The project demonstrates the evolution from a simple monolithic deployment to a fully scalable and cloud-native infrastructure.

- No Elastic IPs were used; all networking was handled via AWS internal DNS and load balancer endpoints.

- Emphasis was placed on understanding and integrating AWS storage and orchestration services.

---

## References
Acknowledge reused code, tutorials, videos, or bibliographic references.  
- <site1-url>  
- <site2-url>  
- <other-sources>  

