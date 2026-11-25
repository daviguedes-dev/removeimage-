# removeimage

Script em Python que apaga automaticamente **prints, imagens e vídeos** da pasta de capturas de tela do Windows:

```
C:\Users\Davi Guedes\Pictures\Screenshots
```

## Requisitos

- Windows 10/11
- Python 3.8 ou superior (testado com Python 3.12)

Nenhuma biblioteca externa é necessária.

## Arquivos

| Arquivo | Função |
|---|---|
| `removeimage.py` | O programa principal |
| `removeimage.bat` | Atalho que permite rodar só `removeimage` no terminal |
| `README.md` | Este arquivo |

## Como usar

Abra qualquer terminal (PowerShell, CMD ou o terminal do VS Code) e digite:

```
removeimage
```

O script mostra a lista de arquivos encontrados e pede confirmação antes de apagar.

### Opções

| Comando | O que faz |
|---|---|
| `removeimage` | Lista os arquivos e pede confirmação (`s/N`) |
| `removeimage -y` | Apaga direto, sem perguntar |
| `removeimage --dry-run` | Só mostra o que seria apagado, sem apagar nada |
| `removeimage -r` | Inclui as subpastas de Screenshots |
| `removeimage -h` | Mostra a ajuda |

As opções podem ser combinadas, por exemplo: `removeimage -r -y`.

### Exemplo de saída

```
Encontrados 3 arquivo(s) (4.2 MB):
  - Captura de tela 2026-11-25 101500.png
  - Captura de tela 2026-11-25 102233.png
  - Gravação de tela 2026-11-25 103010.mp4

Apagar todos esses arquivos? (s/N): s

Pronto! 3 arquivo(s) apagado(s).
```

## Tipos de arquivo removidos

- **Imagens:** `.png` `.jpg` `.jpeg` `.gif` `.bmp` `.webp` `.tif` `.tiff` `.heic` `.jfif` `.svg` `.ico`
- **Vídeos:** `.mp4` `.mkv` `.mov` `.avi` `.wmv` `.webm` `.flv` `.m4v` `.3gp`

Qualquer outro tipo de arquivo (`.txt`, `.pdf`, etc.) é ignorado e **não** é apagado.

## Instalação (comando global)

Para que `removeimage` funcione em qualquer pasta, a pasta do projeto precisa estar no PATH. Isso já foi configurado. Se precisar refazer, rode uma vez no PowerShell:

```powershell
[Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User") + ";C:\Users\'User '\Desktop\removeimage", "User")
```

Depois feche e abra o terminal (ou o VS Code inteiro).

> Se você mover ou renomear a pasta `removeimage`, atualize o caminho no PATH.

## Configuração

Para mudar a pasta alvo ou os tipos de arquivo, edite o início de `removeimage.py`:

```python
PASTA = Path(r"C:\Users\'User'\Pictures\Screenshots")

EXTENSOES = { ".png", ".jpg", ... }
```

## ⚠️ Atenção

Os arquivos são apagados **permanentemente**. Eles **não** vão para a Lixeira.
Na dúvida, rode primeiro `removeimage --dry-run` para conferir o que será removido.

## Códigos de saída

| Código | Significado |
|---|---|
| `0` | Sucesso (ou nada para apagar / cancelado) |
| `1` | Pasta de Screenshots não encontrada |
| `2` | Alguns arquivos não puderam ser apagados |
