# Aplicação HTML Customizável com Kubernetes e Helm
<img src="./img/img.png" alt="jackexpert" width="400"/>

## Introdução

### Descrição do Projeto
O objetivo deste projeto é subir uma página HTML que pode ser facilmente customizada via **ConfigMap** no **Kubernetes**, sem precisar de reconstruir a imagem **Docker**. Dentro do ambiente **DevOps**, o projeto monstra Cloud Native através da Azure e IaC, mostrando o gerenciamento tanto do código do projeto quanto das suas configurações usando **Helm** e **Kubernetes**.


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

> **Dica:** Der uma boa olhada se as ferramentas foram configuradas e nas versões mais atuais, para evitar erros.

## Estrutura do Projeto

### `.github/workflow/`

#### arquivo: `pipeline.yaml`

Mostra o pipeline CI/CD usando o GitHub Actions para rodar os Jobs, responsável por:
- Construção da imagem Docker.
- Exportação para o DockerHub
- Deploy no Kubernetes via Helm (Install).

**Referência**:
- [Artigo para entendimento do assunto em geral](https://www.linkedin.com/pulse/como-criar-um-pipeline-de-cicd-com-o-github-actions-em-quatro-/)
- [Pipeline com Kubernetes](https://github.com/actions-hub/kubectl)

---

### `App/`

#### Arquivo: `html/index.html`

Página com HTML mostrada pelo NGINX, configurada dinamicamente via ConfigMap no Kubernetes.

**Referência**:
- [Kubernetes ConfigMap](https://medium.com/@teme_24/customizing-nginx-html-file-using-kubernetes-configmap-64c715f7512a)

---

#### Diretório: `templates/`

Contém os templates Helm que definem os recursos do Kubernetes, como `ConfigMap`, `Deployment` e `Service`...

**Referências**:
- [Gui do Chart](https://medium.com/@maths.nunes/criando-e-instalando-um-chart-com-o-helm-c3504dc63419)

---

#### Arquivo: `dockerfile`

Mostra como a imagem é empacotada numa imagem Docker com NGINX, configurando permissões para rodar com um usuário não-root.

**Referência**:
- [NGINX](https://hub.docker.com/_/nginx)
- [Umas boas práticas com o Dockerfile](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

---

#### Arquivo: `values.yaml`

Vai declarar valores usados pelos templates Helm, Deixa mais simples as mudanças da aplicação sem modificar diretamente os templates.

**Referências**:
- [Helm values.yaml](https://helm.sh/pt/docs/glossary/#:~:text=Valores%20de%20Configuração%20(values.&text=Valores%20de%20configuração%20são%20uma,ser%20sobrescritas%20durante%20a%20instalação.))

---

#### Arquivo: `chart.yaml`

Metadados(Pequenas informações) sobre o Helm chart, como o nome.

**Referências**:
- [Helm chart.yaml](https://www.freecodecamp.org/portuguese/news/o-que-e-um-helm-chart-um-tutorial-para-iniciantes-no-kubernetes/)

---

### `Infraestrutura/`

Tem os arquivos do Terraform usados para provisionar o cluster AKS.

**Referências**:
- [Tutorial da Hashicorp](https://learn.hashicorp.com/tutorials/terraform/aks)

---

## Fluxo do CI/CD

1. A pipeline olha as alterações e builda a imagem Docker.
2. A imagem é publicada no Docker Hub.
3. Helm atualiza a aplicação no Kubernetes com os novos valores de `values.yaml` e ConfigMap.
