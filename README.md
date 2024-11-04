# Rick and Morty Wishlist

## Objetivo
Este projeto foi desenvolvido como um desafio técnico para a empresa Dilleta, com o objetivo de criar um aplicativo de Wishlist utilizando Flutter.

## Descrição do Aplicativo

O aplicativo possui duas telas principais:
1. **Lista de Personagens**: Exibe uma lista dos personagens da série *Rick and Morty*, obtidos por meio de uma API pública.
2. **Wishlist**: Exibe a lista de personagens favoritados na primeira tela, permitindo ao usuário acessar rapidamente seus personagens favoritos.

### Funcionalidades Principais

- **Persistência de Dados**: Utiliza o `SharedPreferences` para armazenar de forma local os IDs dos personagens favoritados, garantindo que os dados sejam mantidos entre sessões do aplicativo.

- **Lista Paginada e Bufferizada**: A lista principal de personagens utiliza uma abordagem de paginação para otimizar o consumo de memória, carregando apenas os dados necessários conforme o usuário realiza o scroll na tela.

- **Favoritar Personagens**: A ação de favoritar um personagem é realizada de forma assíncrona. Assim, ao selecionar um personagem como favorito, o estado da tela é atualizado imediatamente sem travar a interface. A persistência ocorre em segundo plano, melhorando a experiência do usuário.

### Gerenciamento de Estado
O gerenciamento de estado foi implementado com o pacote `Cubit-Bloc`, facilitando a manutenção e a escalabilidade do aplicativo. Foram criados dois blocos principais:
1. **Gerenciamento da Lista Paginada**: Controla a exibição dos personagens na lista, com atualização conforme a navegação do usuário.
2. **Gerenciamento da Wishlist**: Controla os personagens adicionados à lista de favoritos, exibindo-os na tela de Wishlist.

### Estrutura e Padrão de Projeto
A arquitetura do aplicativo segue o padrão **MVC** (Model-View-Controller) simplificado, respeitando os princípios do *KISS* ("Keep It Simple, Stupid") para facilitar a leitura e a manutenção do código.

## Tecnologias e Bibliotecas Utilizadas

- **Flutter**: Framework utilizado para o desenvolvimento do aplicativo.
- **Cubit-Bloc**: Para o gerenciamento de estado.
- **SharedPreferences**: Para a persistência local dos dados.
- **Rick and Morty API**: API pública para obtenção dos dados dos personagens.

## Considerações Finais

Este projeto foi desenvolvido com foco na simplicidade e performance, garantindo uma experiência fluida e rápida para o usuário ao navegar e gerenciar sua lista de favoritos.
