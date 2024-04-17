# README

Desenvolvi este projeto utilizando Ruby on Rails, seguindo uma arquitetura de microserviços e implementando padrões como Repository e Services para manter o código organizado e claro. Utilizei também o Swagger para documentar a API e facilitar tanto o desenvolvimento quanto os testes.

## Design e Implementação

- **Padrão de Repositório**: Utilizei o Padrão de Repositório para abstrair a camada de dados, tornando o manuseio de dados mais adaptável e escalável. A classe UserRepository gerencia todas as operações de banco de dados relacionadas aos usuários, tornando os controladores e serviços mais limpos e mais fáceis de manter.
- **Camada de Serviço**: As classes UserService e AuthService provêm separação da lógica de negócios do controlador. Elas gerenciam toda a lógica relacionada à gestão e autenticação de usuários, garantindo que os controladores fiquem enxutos e focados apenas em lidar com solicitações e respostas HTTP.
- **Documentação com Swagger**: Abstrai e encapsula a lógica de negócios da aplicação, mantendo uma separação entre o controlador e o modelo.

## Stack

- **Ruby (3.2.2)** e **Rails (7.1.0)**: Escolhi as versões mais recentes para aproveitar as últimas melhorias e recursos oferecidos por essas tecnologias.
- **PostgreSQL**: Banco de dados principal para armazenamento de dados da aplicação.
- **RSpec**: Framework de teste para Ruby, usado para escrever testes unitários e de integração.
- **Swagger**: Configurei o Swagger para gerar automaticamente a documentação para todos os endpoints da API, oferecendo uma interface prática para interação em tempo real com a API durante o desenvolvimento e testes.


## Primeiros Passos

Estas instruções ajudarão você a obter uma cópia do projeto em funcionamento na sua máquina local para fins de desenvolvimento e teste.

### Pré-requisitos

Antes de começar, certifique-se de ter instalado:
- Ruby (2.7 ou mais recente)
- Rails (6.0 ou mais recente)
- PostgreSQL
- Bundler

### Instalação

1. **Clone o repositório:**

   ```bash
   git clone https://github.com/seunomeusuario/segarante_test.git
   cd segarante_test

2. **Instale as dependências:**

   ```bash
   bundle install

3. **Configure o banco de dados:**

   ```bash
   rails db:create db:migrate db:seed

4. **Inicie o servidor:**

   ```bash
   rails server
Isso executará o servidor em http://localhost:3000. Os endpoints da API agora podem ser acessados localmente.

## Utilizando a Documentação Swagger

Para visualizar a documentação da API Swagger e interagir com os endpoints da API:
- Navegue até http://localhost:3000/api-docs no seu navegador.

## Executando os Testes

Para executar os testes RSpec da aplicação, use o comando:

```bash
bundle exec rspec
