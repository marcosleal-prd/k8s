# Namespaces

O Kubernetes suporta vários **clusters virtuais** no mesmo cluster físico. Esses clusters virtuais são chamados de **namespaces**.

Namespace é um recurso destinado para uso em ambientes com muitas equipes (não apenas algumas dezenas de pessoas). Comece a usar namespaces quando precisar dos recursos que eles oferecem.

Para visualizar os namespaces disponíveis no seu cluster execute os comando abaixo:

```bash
kubectl get namespace
```

Você deve conseguir ver algo como abaixo (isso pode variar de acordo com suas permissões no cluster):

```
NAME              STATUS   AGE
default           Active   1d
kube-node-lease   Active   1d
kube-public       Active   1d
kube-system       Active   1d
```

O Kubernetes começa com quatro namespaces iniciais:

-   `default`: Padrão para objetos sem outro namespace.
-   `kube-system`: Dos objetos criados pelo sistema Kubernetes.
-   `kube-public`: Criado automaticamente e é visível por todos os usuários (incluindo aqueles não autenticados).
-  `kube-node-lease`: Para os objetos de concessão associados a cada `node`, o que melhora o desempenho do *node heartbeats* à medida que o cluster é escalado.

## DNS

Ao criar um [serviço](https://kubernetes.io/docs/concepts/services-networking/service/) , você cria uma [entrada DNS](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/) correspondente .

Essa entrada é segue o formato `<service-name>.<namespace-name>.svc.cluster.local`, o que significa que, se um contêiner usar apenas `<service-name>`, será resolvido para o serviço que é local em um espaço para nome.

Isso é útil para usar a mesma configuração em vários namespaces, como `development`, `stagging` e `production`.

## Objetos dentro e fora de namespaces

Nem todos os objetos do Kubernetes estão de fato dentro de um namespace.

Se vc tiver as permissões necessárias poderá ver quais recursos estão dentro de um namespace com o comando:

```bash
kubectl api-resources --namespaced=true
```

Ou para os objetos que não estão dentro de nenhum namespace:

```bash
kubectl api-resources --namespaced=false
```

## Criação de um namespace

Existem basicamente 2 formas de criar um namespace no Kubernetes, uma **declarativa** e outra **imperativa**. É uma recomendação (e até uma boa prática usar a forma declarativa).

### Forma declarativa

A forma declarativa consiste na definição de um objeto e do seu estado desejado por meio de um arquivo de definição. Crie um arquivo chamado `development.yaml`.

Nele adicione a seguinte especificação:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
```

Agora execute no terminal:

```bash
kubectl apply -f ./development.yaml
```

Com isso seu namespace chamado `development` será criado pelo Kubernetes.

Os namespaces também aceitam outras informações para que você tenha ainda mais recursos durante o design da sua arquitetura, por exemplo, poderíamos adicionar uma `label` com o time responsável pelo namespace, por exemplo:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development
  labels:
    team: engineering
```

### Forma imperativa

A forma imperativa faz o uso de comando imperativos para execução de qualquer ação dentro do cluster. A criação do namespace realizada no item anterior seria como mostrado abaixo:

```bash
kubectl create namespace development
```

## Exclusão de namespace

Para excluir um namespace você pode usar a forma declarativa ou imperativa.

De forma declarativa:

```bash
kubectl delete -f ./development.yaml
```

De forma imperativa:
```bash
kubectl delete namespaces <insert-some-namespace-name>
```

## Considerações

Num cenário em que há muitos namespaces para o mesmo cluster, as operações de consultam deverão levar isso em consideração, imagine a recuperação dos pods por exemplo:

```bash
kubectl get pods -n development
```

Namespaces permitem o uso de outros recursos, como a adição de [ResourceQuota](https://kubernetes.io/docs/concepts/policy/resource-quotas/) e [LimitRanger](https://kubernetes.io/docs/concepts/policy/limit-range/) com escopo de namespace.

[**Leia mais na documentação oficial**](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
