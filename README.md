<p align="center">
  <a href="https://github.com/quanthumtech/qai-cli">
    <picture>
      <source srcset="packages/console/app/src/asset/logo-ornate-dark.svg" media="(prefers-color-scheme: dark)">
      <source srcset="packages/console/app/src/asset/logo-ornate-light.svg" media="(prefers-color-scheme: light)">
      <img src="packages/console/app/src/asset/logo-ornate-light.svg" alt="QAI logo" width="200">
    </picture>
  </a>
</p>
<p align="center">O agente de desenvolvimento com IA de código aberto.</p>
<p align="center">
  <a href="https://github.com/quanthumtech/qai-cli/discord"><img alt="Discord" src="https://img.shields.io/discord/1391832426048651334?style=flat-square&label=discord" /></a>
  <a href="https://www.npmjs.com/package/qaicli"><img alt="npm" src="https://img.shields.io/npm/v/qaicli?style=flat-square" /></a>
  <a href="https://github.com/quanthumtech/qai-cli/actions/workflows/publish.yml"><img alt="Build status" src="https://img.shields.io/github/actions/workflow/status/quanthumtech/qai-cli/publish.yml?style=flat-square&branch=dev" /></a>
</p>

---

### Instalação

**Linux / macOS**

```bash
curl -fsSL https://raw.githubusercontent.com/quanthumtech/qai-v2/master/install.sh | sh
```

**Windows (PowerShell)**

```powershell
irm 'https://raw.githubusercontent.com/quanthumtech/qai-v2/master/install.ps1' | iex
```

Após a instalação, rode:

```bash
echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc
qaicli
```

### Atualização

```bash
qaicli update
```

### Desinstalação

```bash
qaicli uninstall
```

---

### Agentes

A QAI inclui dois agentes integrados que você pode trocar com a tecla `Tab`.

- **build** - Agente padrão, com acesso completo para desenvolvimento
- **plan** - Agente somente leitura para análise e exploração de código
  - Nega edições de arquivos por padrão
  - Pede permissão antes de rodar comandos bash
  - Ideal para explorar bases de código desconhecidas ou planejar mudanças

Também includedo um subagente **general** para buscas complexas e tarefas multistep.
Ele é usado internamente e pode ser invocado usando `@general` nas mensagens.

Saiba mais sobre [agentes](https://github.com/quanthumtech/qai-cli/docs/agents).

### Documentação

Para mais informações sobre como configurar a QAI, [**confira nossa documentação**](https://github.com/quanthumtech/qai-cli/docs).

### Contribuindo

Se você tem interesse em contribuir para a QAI, por favor leia nossos [docs de contribuição](./CONTRIBUTING.md) antes de enviar um pull request.

### FAQ

#### Como isso é diferente do Claude Code?

É muito semelhante ao Claude Code em termos de capacidade. Aqui estão as principais diferenças:

- 100% open source
- Não vinculado a nenhum provider. A QAI pode ser usada com Claude, OpenAI, Google, ou até modelos locais. À medida que os modelos evoluem, as diferenças entre eles diminuem e os preços caem, por isso ser independente de provider é importante.
- Suporte LSP pronto para uso
- Foco em TUI. A QAI é construída por usuários de neovim e criadores do terminal.shop; estamos pushing os limites do que é possível no terminal.
- Arquitetura client/server. Isso permite, por exemplo, que a QAI rode no seu computador enquanto você controla remotamente de um app móvel, significando que o frontend TUI é apenas um dos possíveis clientes.

---

**Junte-se à nossa comunidade** [Discord](https://discord.gg/qai) | [X.com](https://x.com/qai)
