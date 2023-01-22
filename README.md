# AWS EC2 LINUX

- [Pré requisitos](#pré-requisitos)
  - [Login na plataforma da AWS](#login-na-plataforma-da-aws)
  - [Donwload da AWS CLI](#donwload-da-aws-cli)
  - [Criação da VPC](#criação-da-vpc)
  - [Criação do Grupo de Segurança](#criação-do-grupo-de-segurança)
- [Criação da instância EC2](#criação-da-instância-ec2)
  - [Especificações da máquina](#especificações-da-máquina)
  - [Criando um Elastic IP](#criando-um-elastic-ip)
- [Configurando SSH](#configurando-ssh)
- [Configurações da instância](#configurações-da-instância)
  - [Instalação do git dentro da instância EC2](#instalação-do-git-dentro-da-instância-ec2)
  - [Instalando Apache](#instalando-apache)
- [Referências](#referências)

</br>

# Pré requisitos

Antes de começar com a criação da instancia, é necessario seguir alguns passos:

## Login na plataforma da AWS

Realize o [login](https://signin.aws.amazon.com/signin?redirect_uri=https%3A%2F%2Fus-east-1.console.aws.amazon.com%2Fconsole%2Fhome%3FhashArgs%3D%2523%26isauthcode%3Dtrue%26region%3Dus-east-1%26skipRegion%3Dtrue%26state%3DhashArgsFromTB_us-east-1_9c6c488a6a6122b5&client_id=arn%3Aaws%3Asignin%3A%3A%3Aconsole%2Fcanvas&forceMobileApp=0&code_challenge=NnQ0BuJJAPgSeUMSXvCGh89C4xNziT0Q4bxL4OFYdGQ&code_challenge_method=SHA-256) na plataforma da AWS. Caso não possua nenhuma conta na AWS, faça o [cadastro gratuitamente](https://portal.aws.amazon.com/billing/signup?nc2=h_ct&src=header_signup&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation&language=pt_br#/start/email), seguindo os passos informados pela plataforma. Lembre-se de fornecer suas informações pessoais de forma verídica, inclusive os dados do seu cartão (Não se preocupe, nenhum valor será cobrado por hora).

</br>

## Donwload da AWS CLI

Para se conectar à sua instancia EC2 criada via Cliente SSH, é preciso ter em sua máquina a AWS CLI, a ferramenta para o gerenciamento dos produtos AWS via linha de comando. 

Para mais informações sobre o download nos dois sitemas, acesse [Installing or updating the latest version of the Amazon CLI](https://docs.amazonaws.cn/en_us/cli/latest/userguide/getting-started-install.html).

</br>

## Criação da VPC

A VPC permite iniciar recursos da AWS em uma rede virtual definida por você se assemelhando a uma rede tradicional, com os benefícios de usar a infraestrutura dimensionável da AWS. Para realizar a criação do VPC, você deve estar logado na plataforma da AWS e pelo painel de navegação selecionar VPC e em seguida Suas VPCs. Feito isso selecione, no canto superior direito, Criar VCP.
Nas Configurações da VPC preencha os campos com as informações necessárias, como a Tag de nome, Bloco CIDR IPv4, CIDR IPv4 e o Bloco CIDR IPv6.

> Para mais informações do que são cada um dos itens acima, acesse [Trabalhar com VPCs](https://docs.aws.amazon.com/pt_br/vpc/latest/userguide/working-with-vpcs.html)
> 

</br>

## Criação do Grupo de Segurança

Um grupo de segurança atua como firewall virtual para as instâncias do EC2 visando controlar o tráfego de entrada e de saída. Para realizar a criação do grupo de segurança, você deve estar logado na plataforma da AWS e pelo painel de navegação selecionar Grupos de Segurança e escolha Criar grupo de segurança. Preencha os itens que achar necessario para os detalhes básicos como Nome do SG, Descrição e a VPC. Selecione também as regras de entrada e de saída.

> Para mais informações sobre a criação do grupo de segurança, acesse [Trabalhar com grupos de segurança](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/working-with-security-groups.html#adding-security-group-rule)
>


</br>

# Criação da instância EC2

Depois de ter realizado todos os pré requisitos, devemos começar com a criação da instancia EC2 da AWS. Dentro da plataforma AWS, pesquise pelo serviço EC2.

</br>

## Especificações da máquina

| Tipo | |
| --- | --- |
| Tags | Name: SEUNOME / Project: PB / CostCenter: PBCompass |
| Imagem do software (AMI) | Amazon Linux 2 Kernel 5.10 AMI 2.0.20221210.1 x86_64 HVM gp2 |
| Tipo de servidor virtual (tipo de instância) | t3.small |
| Armazenamento (Volumes) | 1 volume - 16gb gp2 |

Para mais informações sobre a criação da instância acesse [Comece a usar instâncias de Linux do Amazon EC2](https://www.notion.so/AWS-EC2-LINUX-7e828519636c4a1098f19a7bbab3ad9d).

Use o grupo de segurança e a VPC que você criou anteriormente, na seção de [Pré Requisitos](#pré-requisitos)

> Ao criar sua instância, lembre-se se guardar sua chave de segurança, você irá precisar dela para se conectar com sua instância via SSH.
> 

</br>

## Criando um Elastic IP

Dentro da plataforma AWS, você pode criar onde éé alocado para a conta da AWS e será seu até que você o libere.

Para isso basta ir no dashboar do EC2 e, no painel ao lado esquedo, ir para seção de Rede e Segurança e escolher IPs Elasticos. Para mais informações acesse [Elastic IP addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html).

</br>

# Configurando SSH

Verifique se o SSH está instalado na sua máquina, com o comando:

```bash
dnf list installed | grep openssh
```

Caso não tenha instalado, realize a instalação:

- `dnf install openssh-server`
- `systemctl start sshd`
- `systemctl enable sshd`
- `systemctl disable firewalld`

Descubra o endereço IP por meio `ip addr show`. Para realizar a conexão, basta usar o comando:

```bash
ssh root@ip
```

</br>

# Configurações da instância

## Instalação do git dentro da instância EC2

Para instalar o git em sua máquina, faça o seu download com:

```bash
sudo yum install git
```

Para verificar se está tudo funcionando, execute `git --version`  

</br>

## Instalando Apache

Para instalar o Apache basta executar o comando:

```bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl start httpd.service
```

Por fim, verifique se o sistema está funcionando executando `sudo systemctl status httpd.service`

</br>

# Referências
- [O que é Amazon EC2?](https://docs.aws.amazon.com/pt_br/AWSEC2/latest/UserGuide/concepts.html)
- [Apache](https://httpd.apache.org/)
- [Openssh](https://www.cyberciti.biz/faq/ubuntu-linux-install-openssh-server/)
