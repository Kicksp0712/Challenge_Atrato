# Infraestructura Atrato con AWS y Terraform

Este proyecto configura una infraestructura básica en Amazon Web Services (AWS) utilizando Terraform. La infraestructura incluye una Virtual Private Cloud (VPC), subredes, grupos de seguridad, un Application Load Balancer (ALB), Amazon RDS e instancias EC2. Este README proporciona una descripción general del proyecto e instrucciones sobre cómo configurar las variables para personalizarlo según tus necesidades.

#Requisitos

Antes de comenzar, asegúrate de tener lo siguiente:

- Una cuenta de AWS con los permisos necesarios.
- Terraform instalado en tu máquina local.
- Claves de acceso de AWS y clave secreta con los permisos adecuados configurados como variables de entorno o en el bloque del proveedor de Terraform.

#Configuración

Para personalizar esta infraestructura según tus requisitos específicos, deberás configurar las variables. Aquí están las principales variables que puedes configurar:

- "region": La región de AWS donde se implementará la infraestructura (predeterminada: "us-west-2").
- "access_key" y "secret_key": Tus claves de acceso y clave secreta de AWS para la autenticación.
- "availability_zone": La zona de disponibilidad de AWS que se utilizará (predeterminada: "us-west-2a").
- "cidr_block": El rango de direcciones IP para la VPC (predeterminado: "10.0.0.0/16").
- "subred_publica": El rango de direcciones IP para la subred pública (predeterminado: "10.0.0.0/19").
- "subred_priv_ec2" y "subred_priv_rds": Los rangos de direcciones IP para las subredes privadas.
- "private_subnet_ec2_id" y "private_subnet_rds_id": IDs de las subredes privadas para EC2 y RDS.
- "security_group_id": El ID del grupo de seguridad para las instancias EC2.
- "ami": El ID de la Amazon Machine Image (AMI) para las instancias EC2.
- "vpc", "public_subnet" y "rds_securityG": IDs de varios recursos creados en el proyecto.
- "allowed_ssh": Direcciones IP autorizadas para el acceso SSH a la instancia EC2.

#Uso

1. Clona este repositorio en tu máquina local.
2. Configura las variables en el archivo "variables.tf" según tus requisitos.
3. Inicializa Terraform en el directorio del proyecto: "terraform init".
4. Revisa el plan de Terraform: "terraform plan".
5. Aplica los cambios para crear la infraestructura: "terraform apply".

#Limpieza

Para destruir la infraestructura y liberar los recursos de AWS, puedes utilizar:
"terraform destroy"