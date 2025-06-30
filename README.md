# Keycloak Custom Theme Project

Este projeto configura um Keycloak personalizado com tema customizado usando Docker Compose.

## 📋 Pré-requisitos

- Docker Desktop
- Node.js (versão 16 ou superior)
- pnpm (recomendado) ou npm

## 🚀 Instalação e Execução

### Opção 1: Script Automatizado (Recomendado)

Execute o script PowerShell que automatiza todo o processo:

```powershell
.\setup.ps1
```

### Opção 2: Manual

1. **Instalar dependências do tema:**

   ```bash
   cd themes
   pnpm install  # ou npm install
   ```

2. **Build do tema:**

   ```bash
   pnpm run build      # ou npm run build
   pnpm run build:jar  # ou npm run build:jar
   cd ..
   ```

3. **Iniciar os serviços:**
   ```bash
   docker-compose up --build
   ```

## 🔧 Configuração

### Variáveis de Ambiente

As configurações estão no arquivo `env/.env.development`:

```env
# Keycloak
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin123
KC_DB=mysql
KC_DB_DATABASE=keycloak
KC_DB_USERNAME=keycloak
KC_DB_PASSWORD=keycloak123
KC_DB_URL=jdbc:mysql://db:3306/keycloak

# MySQL
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=keycloak
MYSQL_USER=keycloak
MYSQL_PASSWORD=keycloak123
```

## 🌐 Acesso

- **Keycloak Admin Console**: http://localhost:8080
- **Usuário Admin**: `admin`
- **Senha Admin**: `admin123`
- **MySQL**: `localhost:3307`

## 📊 Comandos Úteis

### Visualizar logs

```bash
docker-compose logs -f
```

### Parar os serviços

```bash
docker-compose down
```

### Reconstruir o tema

```bash
cd themes
pnpm run build && pnpm run build:jar
cd ..
docker-compose restart keycloak
```

### Acessar o container do Keycloak

```bash
docker-compose exec keycloak bash
```

## 🛠️ Desenvolvimento

### Estrutura do Projeto

```
├── docker-compose.yml      # Configuração Docker
├── env/
│   └── .env.development    # Variáveis de ambiente
├── themes/                 # Código do tema customizado
│   ├── src/               # Código fonte (TypeScript/CSS)
│   ├── theme/keywind/     # Templates Freemarker
│   └── html/              # Arquivos HTML estáticos
└── docker/
    └── db/                # Volume do MySQL
```

### Desenvolvimento do Tema

1. Faça alterações nos arquivos em `themes/src/` ou `themes/theme/keywind/`
2. Reconstrua o tema:
   ```bash
   cd themes
   pnpm run build && pnpm run build:jar
   ```
3. Reinicie o Keycloak:
   ```bash
   docker-compose restart keycloak
   ```

### Comandos Make

```bash
make build-front         # Build apenas do frontend
make build-development   # Build da imagem Docker
make start-development   # Build e start completo
```

## 🔍 Troubleshooting

### Erro de conexão com MySQL

- Verifique se o container MySQL está rodando: `docker-compose ps`
- Verifique os logs: `docker-compose logs db`

### Tema não carregando

- Certifique-se que o build foi executado com sucesso
- Verifique se o arquivo JAR foi gerado em `themes/target/`
- Reinicie o container: `docker-compose restart keycloak`

### Porta já em uso

- Verifique se há outros serviços rodando nas portas 8080 ou 3307
- Altere as portas no `docker-compose.yml` se necessário

## 📝 Licença

Este projeto está sob a licença especificada no arquivo LICENSE.
