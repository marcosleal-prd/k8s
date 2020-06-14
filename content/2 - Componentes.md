# Componentes

Um cluster Kubernetes consiste em um conjunto de máquinas operadoras, chamado [nodes](https://kubernetes.io/docs/concepts/architecture/nodes/), que executam aplicativos em contêiner.

Cada cluster possui pelo menos um node (sendo recomendado pelo menos 2).

Aqui está o diagrama de um cluster Kubernetes com todos os componentes ligados.

| ![Architecture Of Kubernetes](../images/components-of-kubernetes.png) |
| :----------------------------------------------------------------------------------------: |
| *Arquitetura k8s [k8s Concepts](https://kubernetes.io/docs/concepts/overview/components/)* |

## Componentes do Plano de Controle

Os componentes do plano de controle tomam decisões globais sobre o cluster (por exemplo, agendamento), além de detectar e responder a eventos do cluster (por exemplo, iniciar um novo [pod](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview/) quando o campo `replicas` de uma implantação estiver insatisfeito).

### kube-apiserver

É um dos principais componentes do Kubernetes, ele expõe a API do Kubernetes para os demais componentes.

O kube-apiserver foi desenvolvido para ser redimensionado horizontalmente de acordo com a demanda, ou seja, com a adição de mais instâncias.

### etcd

O etcd é um _datastore_ chave-valor distribuído que o k8s utiliza para armazenar as especificações, status e configurações do _cluster_. Todos os dados armazenados dentro do etcd são manipulados apenas através da API.

Por questões de segurança, o etcd é por padrão executado apenas em _nodes_ classificados como _master_ no _cluster_ k8s, mas também podem ser executados em _clusters_ externos, específicos para o etcd, por exemplo.

### kube-scheduler

O _scheduler_ é responsável por selecionar o _node_ que irá hospedar um determinado _pod_ para ser executado.

Esta seleção é feita baseando-se na quantidade de recursos disponíveis em cada _node_, como também no estado de cada um dos _nodes_ do _cluster_, garantindo assim que os recursos sejam bem distribuídos.

Os fatores levados em consideração nas decisões de planejamento incluem: requisitos de recursos individuais e coletivos, restrições de hardware / software / política, especificações de afinidade e ant afinidade, localidade dos dados, interferência entre cargas de trabalho e prazos.

### kube-controller-manager

É o _controller manager_ quem garante que o _cluster_ esteja no último estado definido no etcd.

**Por exemplo:**

Se no etcd um _deploy_ está configurado para possuir dez réplicas de um _pod_, é o _controller manager_ quem irá verificar se o estado atual do _cluster_ corresponde a este estado e, em caso negativo, procurará conciliar ambos.

Logicamente, cada [controlador](https://kubernetes.io/docs/concepts/architecture/controller/) é um processo separado, mas para reduzir a complexidade, todos são compilados em um único binário e executados em um único processo.

Esses controladores incluem:

- **Node controller:** Responsável por perceber e responder quando os _nodes_ são desativados.
- **Replication controller:** Responsável por manter o número correto de pods para cada objeto do controlador de replicação no sistema.
- **Endpoints controller:** Preenche o objeto Pontos finais (ou seja, junta-se a Serviços e pods).
- **Service account & Token controllers:** Crie contas padrão e tokens de acesso à API para novos namespaces.

### cloud-controller-manager

É o componente responsável pela interação com o Provedor de Nuvem ao qual o _cluster_ está hospedado.

Ele permite vincular o _cluster_ à API do Provedor de Nuvem e separar os componentes que interagem com a plataforma em nuvem dos componentes que interagem apenas com o _cluster_.

O gerenciador de controlador de nuvem executa apenas controladores específicos do seu provedor de nuvem. Se você estiver executando o Kubernetes em suas próprias instalações ou em um ambiente de aprendizado dentro do seu PC, o cluster não terá um gerenciador de controlador em nuvem.

Controladores que podem ter dependências do provedor de nuvem:

- **Node controller:** Para verificar o provedor de nuvem para determinar se um _node_ foi excluído na nuvem depois que ele para de responder
- **Route controller:** Para configurar rotas na infraestrutura de nuvem subjacente
- **Service controller:** para criar, atualizar e excluir balanceadores de carga do provedor de nuvem

## Componentes do Node

Os componentes do nó são executados em todos os _nodes_, mantendo os pods em execução e fornecendo o ambiente de tempo de execução Kubernetes.

### kubelet

Um agente que é executado em cada _node_ no cluster. Garante que _containers_ estão rodando em um Pod.

O kubelet utiliza um conjunto de PodSpecs que são fornecidos por vários mecanismos e garante que os contêineres descritos nesses PodSpecs estejam funcionando e funcionando corretamente.

**O kubelet não gerencia contêineres que não foram criados pelo Kubernetes.**

### kube-proxy

kube-proxy é um proxy de rede que roda em cada _node_ no cluster, implementando parte dos _services_ do Kubernetes.

O kube-proxy mantém regras de rede nos _nodes_. Essas regras de rede permitem a comunicação em rede com seus Pods a partir de sessões de rede dentro ou fora do cluster.

O kube-proxy usa a camada de filtragem de pacotes do sistema operacional, se houver uma disponível. Caso contrário, o kube-proxy encaminha o próprio tráfego.

### Runtime

É o mecanismo responsável pela execução dos _containers_. O Kubernetes suporta diversos mecanismos, mas o Docker desde do o início já era funcional.
