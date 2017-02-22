# LBAW-FEUP
## Project Specification

This project is aimed at the specification, development and promotion of an information platform available through the Web for the management of a community of collaborative questions and answers.

The platform will be public and will be available online, however, there will be two types of users, authenticated and registered, and unauthenticated users who will only be able to view and search for content.

The platform should allow user registration as well as account cancellation if the user understands. The authenticated user can submit questions and answers, which can be voted on and commented on by others, being possible to associate comments with questions or answers. Each client will have an associated score, which will be calculated according to the votes that he himself assigns. For a more friendly and intuitive environment there will be a search engine that will allow the user to search for existing questions / answers. The questions will be classified according to different categories, which will allow a better organization of the community, and of the system in general.

There should be a back office system privileging some users with administrator roles. Administrators have operating privileges, information entry on the platform, and profile editing for non-administrator users.

AskMe has the purpose of creating a platform of mutual aid and cooperation, where the community can interact, sharing knowledge, through questions and answers.

## Actors and User Stories
### Actors diagram
![](http://imgur.com/HIY77bW)

| Actor | Descrição
| ------- | ----------- |
| **Utilizador** | Utilizador genérico; pode navegar na plataforma e tem acesso a conteúdo público |
| **Visitante** | Utilizador não autenticado e/ou registado na plataforma. Pode ler conteúdo e entrar e/ou registrar-se. |
| **Utilizador Autenticado** | Utilizador com permissões para colocar questões, respostas e votar |
| **Utilizador Autor Pergunta** | Utilizador que coloca uma pergunta. Pode marcar resposta de outros utilizadores como correcta |
| **Editor** | Utilizador com privilégios de operação como editar e remover perguntas/respostas. 
| **Admin** | Utilizador com privilégios de operação e gestão de utilizadores. Pode adicionar, remover ou editar informação pertencente aos utilizadores. |
