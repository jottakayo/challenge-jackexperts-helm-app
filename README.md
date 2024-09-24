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

**Referência**:
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

**Referência**:
- [Helm values.yaml](https://helm.sh/pt/docs/glossary/#:~:text=Valores%20de%20Configuração%20(values.&text=Valores%20de%20configuração%20são%20uma,ser%20sobrescritas%20durante%20a%20instalação.))

---

#### Arquivo: `chart.yaml`

Metadados(Pequenas informações) sobre o Helm chart, como o nome.

**Referência**:
- [Helm chart.yaml](https://www.freecodecamp.org/portuguese/news/o-que-e-um-helm-chart-um-tutorial-para-iniciantes-no-kubernetes/)

---

### `Infraestrutura/`

Tem os arquivos do Terraform usados para provisionar o cluster AKS.

**Referência**:
- [Tutorial da Hashicorp](https://learn.hashicorp.com/tutorials/terraform/aks)

---

## Fluxo do CI/CD

1. A pipeline olha as alterações e builda a imagem Docker.
2. A imagem é publicada no Docker Hub.
3. Helm atualiza a aplicação no Kubernetes com os novos valores de `values.yaml` e ConfigMap.

# Configuração da Imagem Docker


## Pontos Mais Importantes

### Imagem Base
A imagem `nginx:alpine` é pequena e leve. Especificado a plataforma `amd64` por conta do meu cluster AKS, a minha imagem estava gerando a plataforma da minha maquina.

### Criação de Usuário Não-root
Criado o usuário `jack` para rodar o NGINX sem privilégios de root, por segurança. Garantido que todos os diretórios necessários do NGINX fosse de propriedade do `jack`, evitando problemas de permissão como o da imagem abaixo.

<img src="./img/dockererro.png" alt="jackexpert" width="500"/>

### Ajuste de Permissões e Arquivo `.pid`
O arquivo `.pid` do NGINX foi criado e as permissões foram ajustadas para `jack`. Sem isso, o NGINX não conseguiria iniciar corretamente como visto na imagem acima, pois não teria permissões suficientes.

```dockerfile
RUN touch /var/run/nginx.pid \
&& chown -R jack:jack /var/run/nginx.pid \
&& chmod -R 755 /usr/share/nginx/html
```

### Permissão para Rodar na Porta 80
A porta 80 requer privilégios de root. O `setcap` usado, permitiu que NGINX acesse a porta 80 mesmo rodando com o `jack`que não tem permissão de root, mas já que estou usando a versão `nginx:alpine` que é pequena e leve usei o `libcap` para poder usar o `setcap`.

### Expondo a Porta e Definindo o Usuário
Expus a porta 80 para receber conexões HTTP e definindo o user `jack` como o usuário que irá rodar no NGINX.

```dockerfile
EXPOSE 80
USER jack
```


## Criação da Estrutura do Helm Chart

Antes de seguir com a configuração, crie a estrutura do seu Helm Chart com o seguinte comando:

### Gestão da Configuração com Helm

Comando usado para gerar a estrutura básica de diretórios e arquivos do Helm Chart.

```helm create < Metadata >
```

## Estrutura dos Arquivos do Helm Chart

### chart.yaml 

**Metadado:** `Chart.yaml` nele tem os metadados principais do Helm Chart. A versão do Chart (`version`) pode ser usada para contagem de versões.


### Configmap.yaml

**Dinamismo:** O `configmap.yaml` contém o template do HTML com placeholders (`{{ .Values.<variável> }}`) que foram substituídos pelos valores definidos no arquivo `values.yaml`. Isso permitiu customizar a página HTML sem precisar modificar ou reconstruir a imagem Docker.

Comando para verificar o conteúdo dentro do ConfigMap:

```
kubectl describe configmap html-customer-config(nome do configmap) -n(namespace) app(Nome do namespace)
```
Existem formas diferentes de especificar os valores no `configmap.yaml`, o utilizado foi expor o HTML por completo, deve-se seguir bem a sintaxe do .yaml caso contrario ocorrera erros na chamada da variável.
### values.yaml

**Variáveis:**  `Values.yaml` tem os valores que foram injetados no HTML através do ConfigMap. As alterações no arquivo são automaticamente refletidas no conteúdo da página HTML sem a necessidade de rebuilds da image.

## Teste e veja a Aplicação no Cluster

Depois de realizar o deploy da aplicação com Helm, é importante testar e verificar se tudo está funcionando bem, a imagem a seguir é a pratica de como pode acontecer essa verificação.

- **Comando para verificar o ConfigMap e o Pod no cluster:**
- **Comando para visualizar os logs da aplicação:**
<img src="./img/errokube.png" alt="jackexpert" width="500" height="600"/>


Com esses comandos, vai garantir que o ConfigMap foi criado corretamente, que os Pods estão funcionando e que o conteúdo HTML foi renderizado conforme esperado.