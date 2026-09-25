#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 2 ]]; then
    echo "Uso: $0 <arquivo> <coluna>" >&2
    exit 1
fi

arquivo="$1"
coluna="$2"

if [[ ! -f "$arquivo" ]]; then
    echo "erro: '$arquivo' não é um arquivo" >&2
    exit 1
fi

if [[ ! "$coluna" =~ ^[0-9]+$ ]] || [[ "$coluna" -le 0 ]]; then
    echo "erro: '$coluna' deve ser um número inteiro positivo" >&2
    exit 1
fi

nome=$(awk -F, -v c="$coluna" 'NR == 1 { gsub(/"/, "", $c); print $c; exit }' "$arquivo")

if [[ -z "$nome" ]]; then
    echo "erro: coluna '$coluna' não encontrada no cabeçalho" >&2
    exit 1
fi

obs=$(awk 'END { print (NR > 1 ? NR - 1 : 0) }' "$arquivo")
nas=$(awk -F, -v c="$coluna" 'NR > 1 && $c == "NA" { count++ } END { print count+0 }' "$arquivo")

echo "Coluna: $nome"
echo "Observações: $obs"
echo "Valores NA: $nas"

awk -F, -v c="$coluna" '
NR > 1 && $c != "NA" {
    soma[$5] += $c
    n[$5]++
}
END {
    for (m in soma) {
        printf "mes %s: media %.1f em %d dias\n", m, soma[m] / n[m], n[m]
    }
}' "$arquivo" | sort
