# Aplicação HTML Customizável com Kubernetes e Helm
<img src="./img/img.png" alt="jackexpert" width="400"/>

## Introdução

### Descrição do Projeto
O objetivo deste projeto é subir uma página HTML que pode ser facilmente customizada via **ConfigMap** no **Kubernetes**, sem precisar de reconstruir a imagem **Docker**. Dentro do ambiente **DevOps**, o projeto monstra Cloud Native através da Azure e IaC, mostrando o gerenciamento tanto do código do projeto quanto das suas configurações usando **Helm** e **Kubernetes**.

## Pré-Requisitos do projeto

## Arquitetura e Ferramentas Utilizadas

Ferramentas utilizadas para rodar o projeto:

- **Docker**: Usado para containerizar a aplicação NGINX com a página HTML.
    - [Documentação do Docker](https://docs.docker.com/)
    - [O que é Docker?](https://www.docker.com/resources/what-container)
    - [Instalação do Docker](https://docs.docker.com/get-docker/)

- **Kubernetes (AKS)**: Gerenciamento do ciclo de vida do aplicativo através do cluster Kubernetes na Azure. 
    - [Documentação do Kubernetes](https://kubernetes.io/docs/home/)
    - [Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/)
    - [Instalação do Kubectl](https://kubernetes.io/docs/tasks/tools/)

- **Helm**: Implementado para gerenciar os deployments com controle sobre a configuração dinâmica da Pagina.
    - [Documentação do Helm](https://helm.sh/docs/)
    - [Sobre Helm Charts](https://helm.sh/docs/chart_template_guide/getting_started/)
    - [Instalação do Helm](https://helm.sh/docs/intro/install/)

- **Terraform**: Cria o cluster AKS automatizado, usando IaC para manter a infraestrutura replicável caso preciso. 
    - [Documentação do Terraform](https://developer.hashicorp.com/terraform/docs)
    - [Introdução ao Terraform](https://learn.hashicorp.com/terraform)
    - [Instalação do Terraform](https://developer.hashicorp.com/terraform/install)
- **CI/CD Pipeline (GitHub Actions)**: Configurado para automação do build, push da imagem Docker no Docker Hub e deploy no cluster AKS usando Helm(upgrade).
    - [Documentação do GitHub Actions](https://docs.github.com/en/actions)
    - [Introdução do GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/introduction-to-github-actions)
- **Azure CLI**: CLI usada para interagir na nuvem da AKS.
    - [Instalação e documentação do Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

> **Dica:** Olhe bem se as ferramentas foram configuradas e nas versões mais atuais, para evitar erros de compatibilidade.

Estrutura do Projeto