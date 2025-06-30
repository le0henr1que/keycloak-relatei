# Keycloak Custom Theme Project - Documentação Completa

Este projeto implementa uma solução completa de autenticação usando **Keycloak** com tema personalizado **Keywind**, integrado com **MySQL** e executando em containers **Docker**.

## 📋 Índice

- [Visão Geral](#-visão-geral)
- [Arquitetura](#-arquitetura)
- [Pré-requisitos](#-pré-requisitos)
- [Instalação](#-instalação)
- [Configuração](#-configuração)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Tema Personalizado](#-tema-personalizado)
- [Scripts e Automação](#-scripts-e-automação)
- [Comandos Úteis](#-comandos-úteis)
- [Desenvolvimento](#-desenvolvimento)
- [Troubleshooting](#-troubleshooting)
- [Licença](#-licença)

## 🔍 Visão Geral

### Componentes Principais

- **Keycloak**: Servidor de identidade e gerenciamento de acesso
- **MySQL**: Banco de dados para persistência
- **Tema Keywind Customizado**: Interface personalizada com branding "Relatei"
- **Docker Compose**: Orquestração de containers
- **Frontend Build System**: TypeScript + CSS para customização

### Funcionalidades

- ✅ Autenticação personalizada com tema Keywind
- ✅ Interface customizada com branding "Relatei"
- ✅ Integração MySQL para persistência de dados
- ✅ Scripts de automação para setup
- ✅ Ambiente containerizado
- ✅ Build system para temas

## 🏗️ Arquitetura

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Frontend      │    │    Keycloak     │    │     MySQL       │
│   (Tema)        │◄──►│   (Auth Server) │◄──►│   (Database)    │
│   Port: N/A     │    │   Port: 8080    │    │   Port: 3307    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 📋 Pré-requisitos

### Software Necessário

- **Docker Desktop** (versão 20.10+)
- **Node.js** (versão 16 ou superior)
- **pnpm** (recomendado) ou **npm**
- **PowerShell** (para Windows)

### Verificação de Dependências

```powershell
# Verificar Docker
docker --version

# Verificar Node.js
node --version

# Verificar pnpm (opcional)
pnpm --version
```

## 🚀 Instalação

### Opção 1: Script Automatizado (Recomendado)

Execute o script PowerShell que automatiza todo o processo:

```powershell
.\setup.ps1
```

O script executa automaticamente:

1. Verificação de dependências
2. Instalação de pacotes Node.js
3. Build do tema personalizado
4. Inicialização dos containers Docker

### Opção 2: Instalação Manual

#### 1. Instalar Dependências do Tema

```bash
cd themes
pnpm install  # ou npm install
```

#### 2. Build do Tema

```bash
pnpm run build      # ou npm run build
pnpm run build:jar  # ou npm run build:jar
cd ..
```

#### 3. Iniciar Serviços

```bash
docker-compose up --build
```

## 🔧 Configuração

### Variáveis de Ambiente

Arquivo: [`env/.env.development`](env/.env.development)

```env
# Keycloak Configuration
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin123
KC_DB=mysql
KC_DB_DATABASE=keycloak
KC_DB_USERNAME=keycloak
KC_DB_PASSWORD=keycloak123
KC_DB_URL=jdbc:mysql://db:3306/keycloak

# MySQL Configuration
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=keycloak
MYSQL_USER=keycloak
MYSQL_PASSWORD=keycloak123
```

### Portas de Acesso

| Serviço                | Porta | URL                   |
| ---------------------- | ----- | --------------------- |
| Keycloak Admin Console | 8080  | http://localhost:8080 |
| MySQL Database         | 3307  | localhost:3307        |

### Credenciais de Acesso

- **Keycloak Admin**: `admin` / `admin123`
- **MySQL Root**: `root` / `root123`
- **MySQL User**: `keycloak` / `keycloak123`

## 📁 Estrutura do Projeto

```
keycloak/
├── docker-compose.yml              # Configuração Docker Compose
├── setup.ps1                       # Script de automação PowerShell
├── Makefile                        # Comandos Make para desenvolvimento
├── README.md                       # Documentação principal
├── env/
│   └── .env.development            # Variáveis de ambiente
├── docker/
│   └── db/                         # Volume persistente MySQL
└── themes/                         # Código do tema personalizado
    ├── package.json                # Dependências Node.js
    ├── src/                        # Código fonte TypeScript/CSS
    ├── target/                     # Arquivos compilados (.jar)
    ├── html/                       # Arquivos HTML estáticos
    └── theme/keywind/              # Templates Freemarker
        └── login/                  # Templates de login
            ├── document.ftl        # Documento base HTML
            ├── login.ftl           # Página de login
            └── components/         # Componentes reutilizáveis
                └── atoms/
                    └── body.ftl    # Template do corpo da página
```

## 🎨 Tema Personalizado

### Características do Tema Keywind

- **Base**: Tema Keywind para Keycloak
- **Customização**: Branding "Relatei"
- **Tecnologias**: FreeMarker Templates + CSS/TypeScript
- **Responsividade**: Design responsivo otimizado

### Arquivos Principais do Tema

#### [`document.ftl`](themes/theme/keywind/login/document.ftl)

Template base que define a estrutura HTML:

```ftl
<#macro kw script="">
  <title>${msg("loginTitle", (realm.displayName!""))}</title>
  <meta charset="utf-8">
  <meta name="robots" content="noindex, nofollow">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Configuração de meta tags, favicons, estilos e scripts -->
</#macro>
```

#### [`login.ftl`](themes/theme/keywind/login/login.ftl)

Template da página de login com customizações:

```ftl
<div class="text-[#101828] font-[600] text-[30px] leading-[38px]">
  Seja bem-vindo
</div>
<div class="text-[#1D2939] font-[400] text-[16px] leading-32">
  Preencha suas credenciais para acessar sua conta
</div>
```

#### [`body.ftl`](themes/theme/keywind/login/components/atoms/body.ftl)

Template do footer personalizado:

```ftl
<footer>
    <div>© 2024 Relatei. Todos os direitos reservados</div>
    <div class="flex gap-[24px]">
        <div>Termos e Condições</div>
        <div>Privacidade</div>
    </div>
</footer>
```

### Processo de Build

1. **Desenvolvimento**: Editar arquivos em `themes/src/` e `themes/theme/keywind/`
2. **Compilação**: `pnpm run build` - Compila TypeScript e CSS
3. **Empacotamento**: `pnpm run build:jar` - Gera arquivo JAR para Keycloak
4. **Deploy**: Reiniciar container Keycloak para aplicar mudanças

## 🤖 Scripts e Automação

### Script PowerShell ([`setup.ps1`](setup.ps1))

Script principal de automação que:

```powershell
# Verifica dependências
docker --version
node --version

# Instala dependências do tema
Set-Location themes
pnpm install # ou npm install

# Faz build do tema
pnpm run build
pnpm run build:jar

# Inicia serviços Docker
docker-compose up --build -d
```

### Comandos Make

```bash
make build-front         # Build apenas do frontend
make build-development   # Build da imagem Docker
make start-development   # Build e start completo
```

## 📊 Comandos Úteis

### Gerenciamento de Containers

```bash
# Iniciar serviços
docker-compose up -d

# Parar serviços
docker-compose down

# Visualizar logs
docker-compose logs -f

# Visualizar logs específicos
docker-compose logs -f keycloak
docker-compose logs -f db

# Reiniciar serviço específico
docker-compose restart keycloak
```

### Desenvolvimento do Tema

```bash
# Navegar para diretório do tema
cd themes

# Instalar dependências
pnpm install

# Build do tema
pnpm run build

# Gerar JAR
pnpm run build:jar

# Voltar e reiniciar Keycloak
cd ..
docker-compose restart keycloak
```

### Acesso aos Containers

```bash
# Acessar container do Keycloak
docker-compose exec keycloak bash

# Acessar container do MySQL
docker-compose exec db mysql -u keycloak -p
```

### Monitoramento

```bash
# Status dos containers
docker-compose ps

# Uso de recursos
docker stats

# Verificar volumes
docker volume ls
```

## 🛠️ Desenvolvimento

### Fluxo de Desenvolvimento

1. **Fazer alterações** nos arquivos de tema
2. **Recompilar** o tema
3. **Reiniciar** o Keycloak
4. **Testar** as mudanças

### Estrutura de Desenvolvimento

```bash
themes/
├── src/                    # Código fonte
│   ├── styles/            # Arquivos CSS/SCSS
│   └── scripts/           # Arquivos TypeScript/JavaScript
├── theme/keywind/         # Templates FreeMarker
│   └── login/             # Templates de login
└── target/                # Arquivos compilados
```

### Customização Avançada

#### Modificar Estilos

1. Editar arquivos em `themes/src/styles/`
2. Executar `pnpm run build`
3. Reiniciar Keycloak

#### Modificar Templates

1. Editar arquivos `.ftl` em `themes/theme/keywind/`
2. Executar `pnpm run build:jar`
3. Reiniciar Keycloak

#### Adicionar Funcionalidades JavaScript

1. Adicionar scripts em `themes/src/scripts/`
2. Referenciar no [`document.ftl`](themes/theme/keywind/login/document.ftl)
3. Recompilar e reiniciar

## 🔍 Troubleshooting

### Problemas Comuns

#### ❌ Erro de Conexão com MySQL

**Problema**: Keycloak não consegue conectar ao MySQL

**Soluções**:

```bash
# Verificar status dos containers
docker-compose ps

# Verificar logs do MySQL
docker-compose logs db

# Reiniciar serviços na ordem correta
docker-compose down
docker-compose up db -d
# Aguardar MySQL inicializar
docker-compose up keycloak -d
```

#### ❌ Tema Não Carregando

**Problema**: Mudanças no tema não aparecem

**Soluções**:

```bash
# Verificar se o build foi bem-sucedido
cd themes
pnpm run build && pnpm run build:jar

# Verificar se o JAR foi gerado
ls -la target/

# Limpar cache do Keycloak
docker-compose restart keycloak

# Verificar logs do Keycloak
docker-compose logs keycloak | grep -i theme
```

#### ❌ Porta Já em Uso

**Problema**: Erro "port already in use"

**Soluções**:

```bash
# Verificar processos usando as portas
netstat -ano | findstr 8080
netstat -ano | findstr 3307

# Parar processos conflitantes ou alterar portas no docker-compose.yml
```

#### ❌ Problema de Permissões (Docker)

**Problema**: Erro de permissões no Docker

**Soluções**:

```bash
# Windows: Executar PowerShell como Administrador
# Linux/Mac: Usar sudo se necessário
sudo docker-compose up -d
```

#### ❌ Build do Tema Falhando

**Problema**: Erro durante build do tema

**Soluções**:

```bash
# Limpar cache do Node.js
cd themes
rm -rf node_modules package-lock.json
pnpm install

# Verificar versão do Node.js
node --version  # Deve ser 16+

# Usar npm como alternativa
npm install
npm run build
```

### Logs e Diagnóstico

```bash
# Logs completos
docker-compose logs

# Logs filtrados por erro
docker-compose logs | grep -i error

# Logs em tempo real
docker-compose logs -f --tail=100

# Verificar saúde dos containers
docker-compose ps
docker inspect $(docker-compose ps -q keycloak)
```

### Backup e Restauração

```bash
# Backup do banco MySQL
docker-compose exec db mysqldump -u keycloak -p keycloak > backup.sql

# Restaurar backup
docker-compose exec -T db mysql -u keycloak -p keycloak < backup.sql
```

## 📈 Monitoramento e Performance

### Métricas Importantes

```bash
# Uso de memória pelos containers
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Logs de performance do Keycloak
docker-compose logs keycloak | grep -i "startup\|performance"

# Tamanho dos volumes
docker system df
```

### Otimizações

- **Memory**: Ajustar `JAVA_OPTS` no docker-compose.yml
- **Database**: Otimizar configurações MySQL
- **Theme**: Minimizar CSS/JS compilados

## 📝 Licença

Este projeto está sob a licença especificada no arquivo LICENSE.

## 🤝 Contribuição

Para contribuir com o projeto:

1. Fork o repositório
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📞 Suporte

Para suporte técnico:

- 📧 Email: suporte@relatei.com
- 📚 Documentação: [Keycloak Docs](https://www.keycloak.org/documentation)
- 🐛 Issues: Utilize o sistema de issues do repositório

---

**Última atualização**: Junho 2025  
**Versão**: 1.0.0  
**Mantido por**: Equipe Relatei
