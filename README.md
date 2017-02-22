# LBAW-FEUP
## Artifact 1 - Project Specification

This project is aimed at the specification, development and promotion of an information platform available through the Web for the management of a community of collaborative questions and answers.

The platform will be public and will be available online, however, there will be two types of users, authenticated and registered, and unauthenticated users who will only be able to view and search for content.

The platform should allow user registration as well as account cancellation if the user understands. The authenticated user can submit questions and answers, which can be voted on and commented on by others, being possible to associate comments with questions or answers. Each client will have an associated score, which will be calculated according to the votes that he himself assigns. For a more friendly and intuitive environment there will be a search engine that will allow the user to search for existing questions / answers. The questions will be classified according to different categories, which will allow a better organization of the community, and of the system in general.

There should be a back office system privileging some users with administrator roles. Administrators have operating privileges, information entry on the platform, and profile editing for non-administrator users.

AskMe has the purpose of creating a platform of mutual aid and cooperation, where the community can interact, sharing knowledge, through questions and answers.

## Artifact 2 - Actors and User Stories
### Actors diagram
[![ActorDiagram.png](https://s2.postimg.org/r5mr6l9qh/Actor_Diagram.png)](https://postimg.org/image/6lhx83tz9/)


| Actor | Descrição
| ------- | ----------- |
| **Utilizador** | Utilizador genérico; pode navegar na plataforma e tem acesso a conteúdo público |
| **Visitante** | Utilizador não autenticado e/ou registado na plataforma. Pode ler conteúdo e entrar e/ou registrar-se. |
| **Utilizador Autenticado** | Utilizador com permissões para colocar questões, respostas e votar |
| **Utilizador Autor Pergunta** | Utilizador que coloca uma pergunta. Pode marcar resposta de outros utilizadores como correcta |
| **Editor** | Utilizador com privilégios de operação como editar e remover perguntas/respostas. 
| **Admin** | Utilizador com privilégios de operação e gestão de utilizadores. Pode adicionar, remover ou editar informação pertencente aos utilizadores. |

### User Stories

# Utilizador

| ID        | Nome  | User Stories (US)           |  Prioridade   | 
| ------------- | ------------- | ------------- | ----------- |
| US001 | Navegação | Como *Utilizador* quero poder ver o conteúdo da plataforma para ter conhecimento do que se trata e dos proveitos que posso tirar. | Alta |
| US002 | Pesquisa | Como *Utilizador* quero consultar o conteúdo para poder desfrutar dos serviços da plataforma e encontrar aqueles que mais me interessam. | Alta |
| US003 | Estatísticas |Como *Utilizador* quero consultar estatísticas de utilização (por exemplo perguntas / respostas mais votadas) para que possa ter acesso ao conteúdo mais importante e pertinente. | Média |

# Visitante

| ID        | Nome  | User Stories (US)           |  Prioridade   | 
| ------------- | ------------- | ------------- | ----------- |
| US101 | Registar | Como *Visitante* quero poder registar-me para ficar cadastrado na plataforma e, consequentemente, poder autenticar-me | Alta
| US102 | Autenticar | Como *Visitante* quero poder autenticar-me de maneira a poder fazer perguntas, votar, responder a conteúdo e ver perguntas anteriormente feitas por mim | Alta

# Utilizador Autenticado 

| ID        | Nome  | User Stories (US)           |  Prioridade   | 
| ------------- | ------------- | ------------- | ----------- |
| US201 | Adicionar Pergunta | Como *Utilizador Autenticado* pretendo adicionar uma pergunta de forma a enriquecer o conteúdo da plataforma e ser ajudado pela comunidade | Alta
| US202 | Adicionar Resposta | Como *Utilizador Autenticado* pretendo adicionar uma resposta de forma a cooperar numa resposta a uma pergunta e enriquecer o tópico | Alta
| US203 | Votar | Como *Utilizador Autenticado* pretendo votar em perguntas e questões de maneira a realçar bom e mau conteúdo | Alta
| US204 | Adicionar comentário | Como *Utilizador Autenticado* pretendo adicionar comentários a perguntas e respostas de forma a debater informação e/ou pedir mais detalhes sobre o assunto. | Média 
| US205 | Ver minhas perguntas | Como *Utilizador Autenticado* pretendo consultar as minhas perguntas previamente feitas de maneira a acompanhar o tópico ou rever o seu conteúdo. | Média

# Utilizador Autor Pergunta

| ID        | Nome  | User Stories (US)           |  Prioridade   | 
| ------------- | ------------- | ------------- | ----------- |
| US301 | Editar Pergunta | Como *Utilizador Autor Pergunta* pretendo editar a pergunta para que possa modificar o conteúdo. | Média
| US302 | Apagar Pergunta | Como *Utilizador Autor Pergunta* pretendo apagar a pergunta quando quiser que o conteúdo não apareça mais na plataforma | Média
| US303 | Validar Resposta | Como *Utilizador Autor Pergunta* pretendo validar uma resposta que resolva o problema especificado na pergunta. | Média

# Editor

| ID        | Nome  | User Stories (US)           |  Prioridade   | 
| ------------- | ------------- | ------------- | ----------- |
| US401 | Remover Pergunta | Como *Editor* pretendo remover uma pergunta se achar que o conteúdo/estrutura é inadequado. | Média
| US402 | Remover Resposta | Como *Editor* pretendo remover uma resposta se achar que o conteúdo é inadequado. | Média
| US403 | Remover Comentário | Como *Editor* pretendo remover um comentário se achar que o conteúdo é inadequado. | Média

# Admin

| ID        | Nome  | User Stories (US)           |  Prioridade   | 
| ------------- | ------------- | ------------- | ----------- |
| US501 | Remover Utilizador | Como *Admininstrador* pretendo remover utilizadores com conduta errada. | Média
| US502 | Promover Utilizador | Como *Admininistrador* pretendo promover utilizadores a *roles* mais altos para que possam adquirir novas permissões.
| US503 | Despromover Utilizador | Como *Admininstrador* pretendo despromover utilizadores a *roles* mais baixos para que as suas permissões sejam limitadas.
| US504 | Adicionar Categoria de Pergunta | Como *Administrador* pretendo criar novas categorias que os utilizadores utilizarão para etiquetarem as suas perguntas.



