---
title: Lições da auditoria das automações (13/11/2026)
date: 2026-11-13
tags: [contexto, automacao, qualidade, seguranca, gp]
aliases: [lições da auditoria]
---

# Lições da auditoria das automações (13/11/2026)

Em 13/11/2026 todas as automações da GP em produção passaram por uma auditoria:

- quatro revisores leram o código por disciplina e rodaram as suítes;
- um quinto reproduziu o teste de um especialista;
- os achados graves foram conferidos de novo, de forma independente.

Aqui ficam as **classes** de problema e as lições de processo. Os detalhes de
cada app ficam no vault privado de automações, não aqui (repo público).

## Bugs que se repetem entre apps

| Classe | Como aparece | Regra |
|---|---|---|
| Nome de arquivo vindo do usuário vira caminho | `pasta / upload.filename` sem pegar só o nome base; campo de texto ("lote") aceitando `../` | Sempre `Path(nome).name`, recusar `.`/`..`, conferir contenção com `is_relative_to` (não `startswith` de texto) |
| Upload com nome repetido | o segundo arquivo sobrescreve o primeiro sem aviso; num caso a memória de cálculo era lida como a folha de dados | Subpasta por papel ou sufixo único |
| Temporários eternos | sessão e `mkdtemp` nunca apagados, com dado de cliente | Apagar no erro, expirar por idade |
| Entrada inválida vira 500 | arquivo corrompido com cabeçalho válido, número que estoura, JSON no formato errado | Validar e responder 4xx com frase |
| Dependência não declarada | o venv único de produção esconde a falta no `requirements.txt` de um app | Cada app declara o que importa |
| CSS comum vencendo o do app | folha de estilo compartilhada carregada depois do estilo do app | Testar a tela de cada app depois de mudar o estilo comum |
| Valor "aproximado" em documento | campo nominal gravado como máximo, nota fixa contradizendo a fonte | Sem fonte, deixar em branco e avisar ("célula vazia é melhor que preenchida errada") |
| Posição fixa de célula | pressão gravada na célula de temperatura do modelo | Achar a célula pelo rótulo |

## Lições de processo

- **Olhar o trabalho do colega antes de corrigir.** Uma correção foi feita em
  dobro: o conserto já estava mesclado na branch de integração e ainda não
  tinha chegado à produção. Medir a versão de integração primeiro.
- **Teste sem credencial real ao alcance.** Um teste de robustez com e-mail falso
  acabou tentando login num sistema de produção, porque a credencial local
  existia. Proibir no prompt não bastou; esconder a credencial resolve.
- **Gabarito do mesmo projeto da entrada.** Exemplo de outro projeto mostra o
  formato, mas não deixa medir acerto.
- **Medir a unidade nos próprios dados.** A dúvida de unidade da planilha do
  simulador se resolveu recalculando a pressão pela equação dos gases com o
  fator Z da própria planilha: bateu com kgf/cm² absoluta.
- **openpyxl apaga os gráficos** de uma planilha ao salvar. Para atualizar uma
  planilha com gráficos, editar o XML do pacote e conferir que os gráficos
  continuam lá.
- **Relatório de subagente não é evidência.** Dois achados vieram com
  gravidade maior do que a real (um "P1" era latente porque o venv de produção
  é único). Remedir antes de repassar.

## Related

- [Harness de contexto de engenharia](../projects/contexto-engenharia.md)
- [triagem-automacao-gp](../projects/triagem-automacao-gp.md)
- [Contexto](README.md)
