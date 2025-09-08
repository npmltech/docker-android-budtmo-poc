# Emuladores Android com Docker

Este projeto fornece uma maneira fácil de subir e gerenciar múltiplos emuladores Android utilizando Docker e Docker Compose. É ideal para testes de aplicativos, desenvolvimento ou qualquer cenário que exija um ambiente de emulação Android isolado e reproduzível.

## Pré-requisitos

Para utilizar este projeto, você precisará ter os seguintes softwares instalados em sua máquina:

- **Docker**: Certifique-se de que o Docker esteja instalado e configurado corretamente. Você pode seguir as instruções de instalação no [site oficial do Docker](https://docs.docker.com/get-docker/).
- **Docker Compose**: Geralmente, o Docker Compose é instalado junto com o Docker Desktop. Caso não tenha, siga as instruções de instalação na [documentação do Docker Compose](https://docs.docker.com/compose/install/).
- **ADB (Android Debug Bridge)**: O ADB é necessário para interagir com os emuladores. Ele faz parte do Android SDK Platform-Tools. Você pode instalá-lo da seguinte forma:

  **No Ubuntu/Debian:**
  ```bash
  sudo apt update
  sudo apt install android-tools-adb
  ```

  **No Fedora/CentOS:**
  ```bash
  sudo dnf install android-tools
  ```

  **No macOS (com Homebrew):**
  ```bash
  brew install --cask android-platform-tools
  ```

  Para mais informações, consulte a [documentação oficial do ADB](https://developer.android.com/studio/command-line/adb).

- **KVM (Kernel-based Virtual Machine)**: Para um desempenho ideal dos emuladores, é crucial que o KVM esteja habilitado e configurado corretamente. O Docker Android utiliza a virtualização de hardware para acelerar a emulação. Para verificar se o KVM está funcionando, execute os seguintes comandos:

  ```bash
  kvm-ok
  ```
  Se a saída for `KVM acceleration can be used`, o KVM está habilitado. Caso contrário, você precisará habilitá-lo na BIOS/UEFI do seu sistema e/ou instalar os módulos necessários. Para mais detalhes, consulte a documentação do seu sistema operacional ou da sua placa-mãe sobre como habilitar a virtualização de hardware.

## Instalação e Configuração

1. **Clone este repositório** (ou baixe os arquivos `docker-compose.yml`, `start-emulator.sh` e `stop-emulators.sh` para um diretório de sua escolha).

2. **Navegue até o diretório do projeto** no seu terminal:

   ```bash
   cd /caminho/para/o/seu/projeto
   ```

## Uso

### Iniciando os Emuladores

Para iniciar os emuladores Android, execute o script `start-emulator.sh`:

```bash
./start-emulator.sh
```

Este script fará o seguinte:

- Subirá dois contêineres Docker definidos no `docker-compose.yml`:
  - `android-emulator-1`: Um emulador Samsung Galaxy S6, acessível via VNC na porta `6080` e ADB na porta `5555`.
  - `android-emulator-2`: Um emulador Nexus 5, acessível via VNC na porta `6081` e ADB na porta `5556`.
- Reiniciará o servidor ADB para garantir que ele reconheça os novos emuladores.
- Aguardará até que ambos os emuladores estejam completamente prontos e visíveis para o ADB.
- Exibirá a lista de dispositivos ADB conectados.

Você pode acessar a interface VNC de cada emulador através do seu navegador, utilizando as portas `6080` e `6081` (ex: `http://localhost:6080` e `http://localhost:6081`). A senha padrão para o VNC é `123mudar`.

### Parando os Emuladores

Para parar os emuladores e remover os contêineres e volumes associados, execute o script `stop-emulators.sh`:

```bash
./stop-emulators.sh
```

Este script fará o seguinte:

- Derrubará os contêineres Docker dos emuladores.
- Removerá os volumes Docker persistentes (`android_data_1` e `android_data_2`) para garantir um ambiente limpo na próxima execução.
- Removerá quaisquer volumes e redes Docker "dangling" (não utilizados) para limpeza adicional.

## Estrutura do Projeto

- `docker-compose.yml`: Define os serviços Docker para os emuladores Android.
- `start-emulator.sh`: Script para iniciar os emuladores e aguardar sua prontidão.
- `stop-emulators.sh`: Script para parar os emuladores e limpar os recursos Docker.

## Contribuição

Sinta-se à vontade para contribuir com este projeto. Abra issues para sugestões ou problemas e envie pull requests com melhorias.

## Licença

Este projeto está licenciado sob a [Licença MIT](https://opensource.org/licenses/MIT).

