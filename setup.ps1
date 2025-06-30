#!/usr/bin/env pwsh

# Script para configurar e rodar o projeto Keycloak

Write-Host "🚀 Configurando projeto Keycloak..." -ForegroundColor Green

# Verificar se o Docker está rodando
try {
    docker --version | Out-Null
    Write-Host "✅ Docker encontrado" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker não encontrado. Instale o Docker Desktop primeiro." -ForegroundColor Red
    exit 1
}

# Verificar se o Node.js está instalado
try {
    node --version | Out-Null
    Write-Host "✅ Node.js encontrado" -ForegroundColor Green
} catch {
    Write-Host "❌ Node.js não encontrado. Instale o Node.js primeiro." -ForegroundColor Red
    exit 1
}

# Entrar no diretório themes e instalar dependências
Write-Host "📦 Instalando dependências do frontend..." -ForegroundColor Yellow
Set-Location themes

# Verificar se pnpm está instalado, senão usar npm
try {
    pnpm --version | Out-Null
    Write-Host "📦 Usando pnpm para instalar dependências..." -ForegroundColor Cyan
    pnpm install
} catch {
    Write-Host "📦 Usando npm para instalar dependências..." -ForegroundColor Cyan
    npm install
}

# Fazer build do tema
Write-Host "🔨 Fazendo build do tema..." -ForegroundColor Yellow
try {
    pnpm run build
    pnpm run build:jar
} catch {
    npm run build
    npm run build:jar
}

# Voltar ao diretório raiz
Set-Location ..

# Parar containers existentes (se existirem)
Write-Host "🛑 Parando containers existentes..." -ForegroundColor Yellow
docker-compose down

# Iniciar os serviços
Write-Host "🐳 Iniciando serviços Docker..." -ForegroundColor Green
docker-compose up --build -d

Write-Host ""
Write-Host "🎉 Projeto iniciado com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Informações de acesso:" -ForegroundColor Cyan
Write-Host "   🌐 Keycloak Admin Console: http://localhost:8080" -ForegroundColor White
Write-Host "   👤 Admin User: admin" -ForegroundColor White
Write-Host "   🔑 Admin Password: admin123" -ForegroundColor White
Write-Host "   🗄️  MySQL Port: 3307" -ForegroundColor White
Write-Host ""
Write-Host "📊 Para ver os logs:" -ForegroundColor Cyan
Write-Host "   docker-compose logs -f" -ForegroundColor White
Write-Host ""
Write-Host "🛑 Para parar os serviços:" -ForegroundColor Cyan
Write-Host "   docker-compose down" -ForegroundColor White
