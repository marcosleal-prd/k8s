# Introdução

O Kubernetes é uma plataforma portátil, extensível e de código aberto para gerenciar cargas de trabalho e serviços em contêiner, que facilita a configuração declarativa e a automação.

Possui um ecossistema grande e de rápido crescimento. Os serviços, suporte e ferramentas do Kubernetes estão amplamente disponíveis.

### O que é k8s?

Como Kubernetes é uma palavra difícil de se pronunciar - e de se escrever - a comunidade simplesmente o apelidou de k8s, seguindo o padrão i18n (a letra "k" seguida por oito letras e o "s" no final), pronunciando-se simplesmente "kates".

### Principais Recursos

O Kubernetes fornece para você:

**Service discovery e load balancing:**
Kubernetes pode expor um contêiner usando o nome DNS ou usando seu próprio endereço IP.

Se o tráfego para um contêiner for alto, o Kubernetes poderá equilibrar a carga e distribuir o tráfego da rede para que a implantação seja estável.

**Storage orchestration:**
Kubernetes permite montar automaticamente um sistema de armazenamento de sua escolha, como armazenamentos locais, provedores de nuvem pública e muito mais.

**Automated rollouts and rollbacks:**
Você pode descrever o estado desejado para seus contêineres implantados usando o Kubernetes, e ele pode alterar o estado real para o estado desejado a uma taxa controlada.

Por exemplo, você pode automatizar o Kubernetes para criar novos contêineres para sua implantação, remover os contêineres existentes e adotar todos os seus recursos para o novo contêiner.

**Automatic bin packing:**
Você fornece ao Kubernetes um cluster de nós que ele pode usar para executar tarefas em contêiner. Você diz ao Kubernetes quanta CPU e memória (RAM) cada contêiner precisa.

O Kubernetes pode ajustar contêineres nos seus nós para fazer o melhor uso de seus recursos.

**Self-healing:**
Kubernetes reinicia os contêineres que falham, substitui os contêineres, mata os contêineres que não respondem à sua verificação de integridade definida pelo usuário e não os anuncia aos clientes até que estejam prontos para servir.

Esse recurso é bastante percebido com uso de `livenessProbe` e `readinessProbe`.

**Secret and configuration management:**
Kubernetes permite armazenar e gerenciar informações confidenciais, como senhas, tokens OAuth e chaves SSH.

Você pode implantar e atualizar segredos e configuração de aplicativos sem reconstruir suas imagens de contêiner e sem expor segredos em sua configuração de stack.
