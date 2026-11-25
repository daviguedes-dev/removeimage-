"""
removeimage.py - Apaga prints, imagens e vídeos da pasta de Screenshots.

Uso:
    python removeimage.py            -> mostra os arquivos e pede confirmação
    python removeimage.py -y         -> apaga direto, sem perguntar
    python removeimage.py --dry-run  -> só lista o que seria apagado
    python removeimage.py -r         -> inclui subpastas
"""

import argparse
import sys
from pathlib import Path

PASTA = Path(r"C:\Users\Davi Guedes\Pictures\Screenshots")

EXTENSOES = {
    # imagens
    ".png", ".jpg", ".jpeg", ".gif", ".bmp", ".webp", ".tif", ".tiff",
    ".heic", ".jfif", ".svg", ".ico",
    # vídeos
    ".mp4", ".mkv", ".mov", ".avi", ".wmv", ".webm", ".flv", ".m4v", ".3gp",
}


def main() -> int:
    parser = argparse.ArgumentParser(description="Remove imagens e vídeos da pasta Screenshots.")
    parser.add_argument("-y", "--yes", action="store_true", help="apaga sem pedir confirmação")
    parser.add_argument("--dry-run", action="store_true", help="apenas lista, não apaga nada")
    parser.add_argument("-r", "--recursive", action="store_true", help="inclui subpastas")
    args = parser.parse_args()

    if not PASTA.is_dir():
        print(f"Pasta não encontrada: {PASTA}")
        return 1

    padrao = PASTA.rglob("*") if args.recursive else PASTA.iterdir()
    arquivos = [f for f in padrao if f.is_file() and f.suffix.lower() in EXTENSOES]

    if not arquivos:
        print("Nenhuma imagem ou vídeo encontrado. Pasta já está limpa!")
        return 0

    tamanho_mb = sum(f.stat().st_size for f in arquivos) / (1024 * 1024)
    print(f"Encontrados {len(arquivos)} arquivo(s) ({tamanho_mb:.1f} MB):")
    for f in arquivos:
        print(f"  - {f.name}")

    if args.dry_run:
        print("\n[dry-run] Nada foi apagado.")
        return 0

    if not args.yes:
        resposta = input("\nApagar todos esses arquivos? (s/N): ").strip().lower()
        if resposta not in ("s", "sim", "y", "yes"):
            print("Cancelado.")
            return 0

    apagados, erros = 0, 0
    for f in arquivos:
        try:
            f.unlink()
            apagados += 1
        except OSError as e:
            erros += 1
            print(f"Erro ao apagar {f.name}: {e}")

    print(f"\nPronto! {apagados} arquivo(s) apagado(s)." + (f" {erros} erro(s)." if erros else ""))
    return 0 if erros == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
